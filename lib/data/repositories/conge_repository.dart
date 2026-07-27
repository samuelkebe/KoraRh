import '../models/conge_request.dart';

abstract class CongeRepository {
  Future<int> soldeRestant(String employeId, int annee);
  Future<List<DemandeConge>> historique(String employeId);
  Future<DemandeConge> soumettre(DemandeConge demande);
}

class ApiCongeRepository implements CongeRepository {
  final List<DemandeConge> _demandesMock = [
    DemandeConge(
      id: 'cg_1',
      employeId: 'emp_001',
      type: TypeConge.maladie,
      dateDebut: DateTime(2026, 6, 3),
      dateFin: DateTime(2026, 6, 4),
      statut: StatutConge.valide,
      commentaire: 'Certificat médical joint',
    ),
    DemandeConge(
      id: 'cg_2',
      employeId: 'emp_001',
      type: TypeConge.sansSolde,
      dateDebut: DateTime(2026, 5, 10),
      dateFin: DateTime(2026, 5, 10),
      statut: StatutConge.refuse,
      commentaire: 'Période de forte activité commerciale',
    ),
  ];

  @override
  Future<int> soldeRestant(String employeId, int annee) async {
    // TODO: GET /employes/{id}/solde-conge?annee=...
    await Future.delayed(const Duration(milliseconds: 300));
    return 14;
  }

  @override
  Future<List<DemandeConge>> historique(String employeId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_demandesMock);
  }

  @override
  Future<DemandeConge> soumettre(DemandeConge demande) async {
    // TODO: POST /conges — le statut initial reste "en attente" jusqu'à
    // validation par le manager côté web.
    await Future.delayed(const Duration(milliseconds: 400));
    _demandesMock.insert(0, demande);
    return demande;
  }
}
