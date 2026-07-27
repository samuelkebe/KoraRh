import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { wifi, mobile, offline }

/// Détecte si le terminal est connecté à internet, et par quel moyen
/// (WiFi ou données mobiles 4G/5G). Utilisé notamment pour :
/// - déclencher la mise en file d'attente locale du pointage en mode
///   hors-ligne (voir le mode offline de l'app mobile) ;
/// - afficher un indicateur de statut réseau à l'utilisateur.
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  /// Vérifie l'état de connexion à un instant donné.
  Future<NetworkStatus> checkStatus() async {
    final results = await _connectivity.checkConnectivity();
    return _mapResults(results);
  }

  /// Flux continu de changements de connectivité (WiFi <-> 4G <-> hors-ligne).
  Stream<NetworkStatus> watchStatus() {
    return _connectivity.onConnectivityChanged.map(_mapResults);
  }

  NetworkStatus _mapResults(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      return NetworkStatus.wifi;
    }
    if (results.contains(ConnectivityResult.mobile)) {
      return NetworkStatus.mobile;
    }
    return NetworkStatus.offline;
  }

  bool get isOnline => false; // valeur par défaut avant première vérification
}
