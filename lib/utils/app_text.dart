import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typographie Kora : Fraunces (serif) pour les moments de marque
/// (logo, montants, titres de bienvenue) et Manrope (sans-serif) pour
/// toute l'interface — exactement le pairing utilisé dans le prototype
/// HTML (`font-family:'Fraunces'...` / `font-family:'Manrope'...`).
class AppText {
  AppText._();

  static TextStyle _fraunces({
    required double size,
    FontWeight weight = FontWeight.w500,
    Color color = AppColors.textDark,
  }) =>
      GoogleFonts.fraunces(fontSize: size, fontWeight: weight, color: color);

  static TextStyle _manrope({
    required double size,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.textDark,
  }) =>
      GoogleFonts.manrope(fontSize: size, fontWeight: weight, color: color);

  // ---- Marque ----
  static TextStyle brandName = _fraunces(size: 32, weight: FontWeight.w600, color: AppColors.gold500);
  static TextStyle brandTagline = _manrope(size: 14, color: AppColors.indigoMuted);

  // ---- En-tête d'accueil ----
  static TextStyle greetingSmall = _manrope(
    size: 12,
    weight: FontWeight.w600,
    color: AppColors.indigoMuted,
  ).copyWith(letterSpacing: 0.4);
  static TextStyle greetingName = _fraunces(size: 26, weight: FontWeight.w500, color: AppColors.white);
  static TextStyle greetingDate = _manrope(size: 13, color: Color(0xFF8791B4));

  // ---- Titres de section ----
  static TextStyle sectionTitle = _manrope(size: 14, weight: FontWeight.w700);

  // ---- Cartes / listes ----
  static TextStyle listTitle = _manrope(size: 13.5, weight: FontWeight.w600);
  static TextStyle listSub = _manrope(size: 12, color: AppColors.textMuted);
  static TextStyle summaryLabel = _manrope(
    size: 11,
    weight: FontWeight.w600,
    color: AppColors.textMuted,
  ).copyWith(letterSpacing: 0.3);
  static TextStyle summaryValue = _manrope(size: 20, weight: FontWeight.w700);

  // ---- Formulaires / boutons ----
  static TextStyle fieldLabel = _manrope(size: 12, weight: FontWeight.w600, color: AppColors.indigoMuted);
  static TextStyle inputText = _manrope(size: 14, color: AppColors.white);
  static TextStyle buttonText = _manrope(size: 15, weight: FontWeight.w700, color: AppColors.indigo900);
  static TextStyle loginHint = _manrope(size: 12, color: AppColors.indigoMuted);

  // ---- Congés ----
  static TextStyle balanceNum = _fraunces(size: 32, weight: FontWeight.w600, color: AppColors.gold500);
  static TextStyle balanceLabel = _manrope(size: 12, color: AppColors.indigoMuted);
  static TextStyle tabLabel = _manrope(size: 13, weight: FontWeight.w700, color: AppColors.textMuted);
  static TextStyle congeType = _manrope(size: 14, weight: FontWeight.w700);
  static TextStyle congeDates = _manrope(size: 12.5, color: AppColors.textMuted);
  static TextStyle badge = _manrope(size: 11, weight: FontWeight.w700);

  // ---- Notifications ----
  static TextStyle notifTitle = _manrope(size: 13.5, weight: FontWeight.w700);
  static TextStyle notifBody = _manrope(size: 12.5, color: AppColors.textMuted);

  // ---- Profil ----
  static TextStyle profilName = _fraunces(size: 20, weight: FontWeight.w500, color: AppColors.white);
  static TextStyle profilRole = _manrope(size: 13, color: AppColors.indigoMuted);
  static TextStyle avatarInitials = _fraunces(size: 28, weight: FontWeight.w600, color: AppColors.indigo900);
  static TextStyle infoLabel = _manrope(size: 13.5, color: AppColors.textMuted);
  static TextStyle infoValue = _manrope(size: 13.5, weight: FontWeight.w600);
  static TextStyle docItem = _manrope(size: 13, weight: FontWeight.w600);
}
