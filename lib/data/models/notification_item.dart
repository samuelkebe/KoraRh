enum TypeNotification { conge, pointage, annonce }

class NotificationItem {
  final String id;
  final TypeNotification type;
  final String titre;
  final String corps;
  final DateTime recueLe;
  final bool lue;

  const NotificationItem({
    required this.id,
    required this.type,
    required this.titre,
    required this.corps,
    required this.recueLe,
    this.lue = false,
  });

  NotificationItem marquerCommeLue() {
    return NotificationItem(
      id: id,
      type: type,
      titre: titre,
      corps: corps,
      recueLe: recueLe,
      lue: true,
    );
  }
}
