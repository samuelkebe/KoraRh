import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Rayons de bordure et ombres, alignés sur les valeurs `border-radius`
/// et `box-shadow` du prototype HTML.
class AppRadius {
  AppRadius._();

  static const card = 20.0; // .punch-card
  static const cardMd = 16.0; // .summary-card
  static const cardSm = 14.0; // .list-item, .notif-item
  static const cardXs = 12.0; // .conge-card
  static const balance = 18.0; // .balance-card
  static const field = 11.0; // form fields
  static const iconBox = 10.0; // .list-icon
  static const button = 12.0; // .btn-primary, login inputs
  static const pill = 20.0; // badges
}

class AppShadows {
  AppShadows._();

  /// box-shadow: 0 2px 10px rgba(27,35,64,0.06); — utilisée sur toutes
  /// les cartes blanches (punch-card, summary-card, list-item...).
  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x0F1B2340), blurRadius: 10, offset: Offset(0, 2)),
  ];

  /// box-shadow: 0 2px 8px rgba(27,35,64,0.05); — ombre légèrement plus
  /// discrète utilisée sur les listes (notif-item, list-item denses).
  static const List<BoxShadow> listItem = [
    BoxShadow(color: Color(0x0D1B2340), blurRadius: 8, offset: Offset(0, 2)),
  ];

  /// box-shadow: 0 30px 60px rgba(27,35,64,0.25); — ombre du cadre de
  /// téléphone dans le prototype (non utilisée directement dans l'app,
  /// gardée pour cohérence si un cadre est reproduit ailleurs, ex: web).
  static const List<BoxShadow> phoneFrame = [
    BoxShadow(color: Color(0x401B2340), blurRadius: 60, offset: Offset(0, 30)),
  ];
}

/// Couleurs de badge de statut de congé, alignées sur `.badge.pending`,
/// `.badge.approved`, `.badge.refused` du prototype.
class AppBadgeColors {
  AppBadgeColors._();

  static const pendingBg = AppColors.gold100;
  static const pendingText = AppColors.gold700;
  static const approvedBg = AppColors.green100;
  static const approvedText = AppColors.green;
  static const refusedBg = AppColors.red100;
  static const refusedText = AppColors.red;
}
