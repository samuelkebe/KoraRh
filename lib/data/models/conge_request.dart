enum TypeConge { paye, maladie, sansSolde, exceptionnel }

enum StatutConge { enAttente, valide, refuse }

extension TypeCongeLabel on TypeConge {
  String get label {
    switch (this) {
      case TypeConge.paye:
        return 'Congé payé';
      case TypeConge.maladie:
        return 'Maladie';
      case TypeConge.sansSolde:
        return 'Sans solde';
      case TypeConge.exceptionnel:
        return 'Exceptionnel';
    }
  }
}

extension StatutCongeLabel on StatutConge {
  String get label {
    switch (this) {
      case StatutConge.enAttente:
        return 'En attente';
      case StatutConge.valide:
        return 'Validé';
      case StatutConge.refuse:
        return 'Refusé';
    }
  }
}

class DemandeConge {
  final String id;
  final String employeId;
  final TypeConge type;
  final DateTime dateDebut;
  final DateTime dateFin;
  final String? commentaire;
  final StatutConge statut;

  const DemandeConge({
    required this.id,
    required this.employeId,
    required this.type,
    required this.dateDebut,
    required this.dateFin,
    this.commentaire,
    this.statut = StatutConge.enAttente,
  });

  int get nombreJours => dateFin.difference(dateDebut).inDays + 1;

  DemandeConge copyWith({StatutConge? statut}) {
    return DemandeConge(
      id: id,
      employeId: employeId,
      type: type,
      dateDebut: dateDebut,
      dateFin: dateFin,
      commentaire: commentaire,
      statut: statut ?? this.statut,
    );
  }
}
