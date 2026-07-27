import 'package:flutter/foundation.dart';

import '../data/models/notification_item.dart';

/// Pour le MVP, l'historique des notifications est alimenté localement
/// (les push entrants via NotificationService viendraient s'y ajouter
/// en conditions réelles, en écoutant FirebaseMessaging.onMessage).
class NotificationsViewModel extends ChangeNotifier {
  List<NotificationItem> notifications = [
    NotificationItem(
      id: 'n1',
      type: TypeNotification.conge,
      titre: 'Congé validé',
      corps: 'Votre demande du 20 au 22 juillet a été validée par votre manager.',
      recueLe: DateTime.now().subtract(const Duration(hours: 2)),
      lue: false,
    ),
    NotificationItem(
      id: 'n2',
      type: TypeNotification.pointage,
      titre: 'Rappel de pointage',
      corps: "N'oubliez pas de pointer votre sortie avant de quitter le bureau.",
      recueLe: DateTime.now().subtract(const Duration(days: 1)),
      lue: true,
    ),
    NotificationItem(
      id: 'n3',
      type: TypeNotification.annonce,
      titre: 'Annonce entreprise',
      corps: "Le bureau sera fermé le 15 août pour l'Assomption.",
      recueLe: DateTime.now().subtract(const Duration(days: 2)),
      lue: true,
    ),
  ];

  int get nombreNonLues => notifications.where((n) => !n.lue).length;

  void marquerCommeLue(String id) {
    notifications = notifications
        .map((n) => n.id == id ? n.marquerCommeLue() : n)
        .toList();
    notifyListeners();
  }

  void ajouterNotificationRecue(NotificationItem item) {
    notifications.insert(0, item);
    notifyListeners();
  }
}
