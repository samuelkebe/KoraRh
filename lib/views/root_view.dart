import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text.dart';
import 'conges_view.dart';
import 'home_view.dart';
import 'notifications_view.dart';
import 'profil_view.dart';

/// Coquille de navigation : reproduit la `.bottom-nav` du prototype
/// (fond blanc, bordure supérieure `--border`, icône + libellé, couleur
/// active `--indigo-900`, inactive `--text-muted`).
class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int _index = 0;

  final _screens = const [
    HomeView(),
    CongesView(),
    NotificationsView(),
    ProfilView(),
  ];

  static const _items = [
    (icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Accueil'),
    (icon: Icons.beach_access_outlined, activeIcon: Icons.beach_access, label: 'Congés'),
    (icon: Icons.notifications_outlined, activeIcon: Icons.notifications, label: 'Notifs'),
    (icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profil'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
        child: SafeArea(
          top: false,
          child: Row(
            children: List.generate(_items.length, (i) {
              final actif = i == _index;
              final item = _items[i];
              final couleur = actif ? AppColors.indigo900 : AppColors.textMuted;
              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => _index = i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(actif ? item.activeIcon : item.icon, size: 22, color: couleur),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: AppText.summaryLabel.copyWith(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: couleur,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
