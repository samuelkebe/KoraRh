import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../data/models/conge_request.dart';

class CongesViewModel extends ChangeNotifier {
  // Mock employee ID
  static const String _mockEmployeId = 'emp_001';



  int soldeJoursRestants = 18;
  List<DemandeConge> historique = [
    DemandeConge(
      id: 'cong_001',
      employeId: _mockEmployeId,
      type: TypeConge.sansSolde,
      dateDebut: DateTime(2024, 1, 15),
      dateFin: DateTime(2024, 1, 19),
      // statut: StatutDemande.approuve,
      commentaire: 'Vacances familiales',
    ),
    DemandeConge(
      id: 'cong_002',
      employeId: _mockEmployeId,
      type: TypeConge.maladie,
      dateDebut: DateTime(2024, 3, 10),
      dateFin: DateTime(2024, 3, 11),
      // statut: StatutDemande.approuve,
      commentaire: 'Rendez-vous médical',
    ),
    DemandeConge(
      id: 'cong_003',
      employeId: _mockEmployeId,
      type: TypeConge.exceptionnel,
      dateDebut: DateTime(2024, 6, 20),
      dateFin: DateTime(2024, 6, 20),
      // statut: StatutDemande.enAttente,
      commentaire: 'Démarches administratives',
    ),
  ];
  bool chargementEnCours = false;
  bool soumissionEnCours = false;
  String? erreur;

  Future<void> charger() async {
    chargementEnCours = true;
    notifyListeners();

    // Mock: Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data already initialized in fields
    soldeJoursRestants = 18;

    chargementEnCours = false;
    notifyListeners();
  }

  Future<bool> soumettreDemande({
    required TypeConge type,
    required DateTime dateDebut,
    required DateTime dateFin,
    String? commentaire,
  }) async {
    erreur = null;

    if (dateFin.isBefore(dateDebut)) {
      erreur = 'La date de fin doit être postérieure à la date de début.';
      notifyListeners();
      return false;
    }

    soumissionEnCours = true;
    notifyListeners();

    final demande = DemandeConge(
      id: const Uuid().v4(),
      employeId: _mockEmployeId,
      type: type,
      dateDebut: dateDebut,
      dateFin: dateFin,
      // statut: StatutDemande.enAttente,
      commentaire: commentaire,
    );

    // Mock: Simulate submission delay
    await Future.delayed(const Duration(milliseconds: 800));

    historique.insert(0, demande);
    soldeJoursRestants -= (dateFin.difference(dateDebut).inDays + 1);

    soumissionEnCours = false;
    notifyListeners();
    return true;
  }
}
