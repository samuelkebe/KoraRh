import 'package:flutter/material.dart';

/// Palette Kora — reprise à l'identique des variables CSS du prototype
/// (`prototype-app-rh.html`), pour garantir une fidélité visuelle totale
/// entre le prototype web et l'application Flutter.
class AppColors {
  AppColors._();

  // Couleur primaire
  static const indigo900 = Color(0xFF1B2340);
  static const primaryColor = indigo900;

  // Couleur secondaire
  static const gold500 = Color(0xFFE8A93E);
  static const secondaryColor = gold500;
  static const gold700 = Color(0xFFB9822A);
  static const gold100 = Color(0xFFFBEACB);

  // Background
  static const cream = Color(0xFFF6F3EC);
  static const white = Color(0xFFFFFFFF);

  // Vert pour le bouton d'entrée
  static const green = Color(0xFF3F9463);
  static const green100 = Color(0xFFDEEEE3);

  // Rouge pour les erreurs
  static const red = Color(0xFFC1443B);
  static const red100 = Color(0xFFF6DEDC);

  // Texte et bordures
  static const textDark = Color(0xFF1D2233);
  static const textMuted = Color(0xFF6B7280);
  static const border = Color(0xFFE4E0D6);

  // Couleur utilisée pour le texte secondaire sur fond indigo
  static const indigoMuted = Color(0xFFA9B0CC);
}
