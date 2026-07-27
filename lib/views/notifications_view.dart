import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../data/models/notification_item.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimens.dart';
import '../utils/app_text.dart';
import '../viewmodels/notifications_viewmodel.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NotificationsViewModel>();

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: vm.notifications.length,
          itemBuilder: (context, index) {
            final n = vm.notifications[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.cardSm),
                boxShadow: AppShadows.listItem,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadius.cardSm),
                onTap: () => context.read<NotificationsViewModel>().marquerCommeLue(n.id),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: _couleurFond(n.type),
                        borderRadius: BorderRadius.circular(AppRadius.iconBox),
                      ),
                      child: Icon(_icone(n.type), size: 16, color: _couleurIcone(n.type)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(n.titre, style: AppText.notifTitle),
                          const SizedBox(height: 3),
                          Text(n.corps, style: AppText.notifBody),
                        ],
                      ),
                    ),
                    if (!n.lue)
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(top: 4, left: 6),
                        decoration: const BoxDecoration(color: AppColors.gold500, shape: BoxShape.circle),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  IconData _icone(TypeNotification type) {
    switch (type) {
      case TypeNotification.conge:
        return Icons.check;
      case TypeNotification.pointage:
        return Icons.access_time;
      case TypeNotification.annonce:
        return Icons.campaign;
    }
  }

  Color _couleurFond(TypeNotification type) {
    switch (type) {
      case TypeNotification.conge:
        return AppColors.green100;
      case TypeNotification.pointage:
        return AppColors.gold100;
      case TypeNotification.annonce:
        return AppColors.gold100;
    }
  }

  Color _couleurIcone(TypeNotification type) {
    switch (type) {
      case TypeNotification.conge:
        return AppColors.green;
      case TypeNotification.pointage:
        return AppColors.gold700;
      case TypeNotification.annonce:
        return AppColors.gold700;
    }
  }
}
