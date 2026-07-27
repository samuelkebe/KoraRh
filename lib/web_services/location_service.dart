import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// Coordonnées simplifiées renvoyées par le service.
class LocationPoint {
  final double latitude;
  final double longitude;
  final DateTime capturedAt;

  const LocationPoint({
    required this.latitude,
    required this.longitude,
    required this.capturedAt,
  });
}

/// Service dédié à la géolocalisation temps réel.
///
/// Utilisé au moment du pointage pour vérifier que l'employé se trouve
/// bien dans le rayon autorisé autour du site (voir [isWithinAllowedZone]),
/// et pour tout suivi live (`watchPosition`) si l'entreprise l'exige.
class LocationService {
  StreamSubscription<Position>? _positionSubscription;

  /// Demande la permission de localisation à l'utilisateur.
  Future<bool> requestPermission() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  /// Vérifie que le service de localisation est actif sur le terminal.
  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  /// Récupère la position actuelle une seule fois (ex: au moment du clic
  /// sur "pointer").
  Future<LocationPoint> getCurrentPosition() async {
    final hasPermission = await requestPermission();
    if (!hasPermission) {
      throw LocationServiceException('Permission de localisation refusée.');
    }

    final serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceException('Le GPS est désactivé sur ce terminal.');
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    return LocationPoint(
      latitude: position.latitude,
      longitude: position.longitude,
      capturedAt: DateTime.now(),
    );
  }

  /// Diffuse la position en continu (utile pour un suivi temps réel,
  /// par exemple pour les commerciaux itinérants).
  Stream<LocationPoint> watchPosition() {
    const settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // mètres avant nouvelle notification
    );

    return Geolocator.getPositionStream(locationSettings: settings).map(
      (position) => LocationPoint(
        latitude: position.latitude,
        longitude: position.longitude,
        capturedAt: DateTime.now(),
      ),
    );
  }

  /// Calcule la distance (en mètres) entre la position actuelle et le
  /// centre du site autorisé, puis vérifie qu'elle est dans le rayon.
  bool isWithinAllowedZone({
    required LocationPoint current,
    required double siteLatitude,
    required double siteLongitude,
    required double allowedRadiusMeters,
  }) {
    final distance = Geolocator.distanceBetween(
      current.latitude,
      current.longitude,
      siteLatitude,
      siteLongitude,
    );
    return distance <= allowedRadiusMeters;
  }

  void dispose() {
    _positionSubscription?.cancel();
  }
}

class LocationServiceException implements Exception {
  final String message;
  LocationServiceException(this.message);

  @override
  String toString() => message;
}
