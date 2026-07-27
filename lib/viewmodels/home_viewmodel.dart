import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../data/models/pointage.dart';
import '../web_services/connectivity_service.dart';

/// ViewModel de l'écran Pointage (accueil).
/// Orchestre géolocalisation, connectivité et enregistrement du
/// pointage — la View ne fait qu'afficher l'état exposé ici.
class HomeViewModel extends ChangeNotifier {
  // Mock employee ID
  static const String _mockEmployeId = 'emp_001';

  static const double _siteLatitude = 5.3599; // exemple : site Abidjan
  static const double _siteLongitude = -4.0083;
  static const double _rayonAutoriseMetres = 150;

  bool pointeActuellement = false; // true = dernier événement = entrée
  bool enCours = false;
  String? messageErreur;
  NetworkStatus reseau = NetworkStatus.offline;
  List<Pointage> historique = [
    Pointage(
      id: 'ptr_001',
      employeId: _mockEmployeId,
      heure: DateTime(2024, 7, 19, 8, 15),
      type: TypePointage.entree,
      latitude: 5.3599,
      longitude: -4.0083,
      synchronise: true,
    ),
    Pointage(
      id: 'ptr_002',
      employeId: _mockEmployeId,
      heure: DateTime(2024, 7, 19, 17, 30),
      type: TypePointage.sortie,
      latitude: 5.3599,
      longitude: -4.0083,
      synchronise: true,
    ),
    Pointage(
      id: 'ptr_003',
      employeId: _mockEmployeId,
      heure: DateTime(2024, 7, 18, 8, 20),
      type: TypePointage.entree,
      latitude: 5.3599,
      longitude: -4.0083,
      synchronise: true,
    ),
    Pointage(
      id: 'ptr_004',
      employeId: _mockEmployeId,
      heure: DateTime(2024, 7, 18, 17, 45),
      type: TypePointage.sortie,
      latitude: 5.3599,
      longitude: -4.0083,
      synchronise: true,
    ),
  ];
  StreamSubscription<NetworkStatus>? _connectiviteSub;

  Future<void> chargerHistorique() async {
    // Mock: Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 500));
    notifyListeners();
  }

  // void _ecouterConnectivite() {
  //   _connectiviteSub = _connectivityService.watchStatus().listen((status) async {
  //     reseau = status;
  //     notifyListeners();
  //
  //     // Dès que le réseau revient, on tente de resynchroniser la file
  //     // locale constituée pendant le mode hors-ligne.
  //     if (status != NetworkStatus.offline) {
  //       await _pointageRepository.synchroniserEnAttente();
  //     }
  //   });
  // }

  /// Cas d'usage principal : bouton "Pointer".
  /// 1. Récupère la position GPS en temps réel.
  /// 2. Vérifie que l'employé est dans la zone autorisée du site.
  /// 3. Enregistre le pointage (avec bascule hors-ligne automatique).
  /// 4. Déclenche une notification instantanée de confirmation.
  Future<void> pointer() async {
    enCours = true;
    messageErreur = null;
    notifyListeners();

    // Mock: Simulate GPS check and processing
    await Future.delayed(const Duration(milliseconds: 800));

    final type = pointeActuellement ? TypePointage.sortie : TypePointage.entree;

    final pointage = Pointage(
      id: const Uuid().v4(),
      employeId: _mockEmployeId,
      heure: DateTime.now(),
      type: type,
      latitude: _siteLatitude,
      longitude: _siteLongitude,
      synchronise: true,
    );

    historique.insert(0, pointage);
    pointeActuellement = !pointeActuellement;

    enCours = false;
    notifyListeners();
  }

  String _formatHeure(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  void dispose() {
    _connectiviteSub?.cancel();
    super.dispose();
  }
}
