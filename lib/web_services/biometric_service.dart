import 'dart:io';
import 'package:local_auth/local_auth.dart';

/// Authentification biométrique cross-plateforme.
///
/// `local_auth` détecte automatiquement la méthode disponible sur le
/// terminal : empreinte digitale (Android/Touch ID) ou reconnaissance
/// faciale (Face ID sur iOS, biométrie faciale sur Android récents).
/// On n'a pas besoin de brancher deux implémentations différentes :
/// le plugin choisit la bonne méthode selon l'OS et le matériel.
class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Vérifie si le terminal peut effectuer une authentification
  /// biométrique (matériel présent + biométrie enrôlée par l'utilisateur).
  Future<bool> canUseBiometrics() async {
    final canCheck = await _localAuth.canCheckBiometrics;
    final isSupported = await _localAuth.isDeviceSupported();
    return canCheck && isSupported;
  }

  /// Retourne un libellé adapté à la plateforme, pour l'affichage
  /// ("Face ID" sur iOS, "Empreinte digitale" sur Android).
  Future<String> availableMethodLabel() async {
    final methods = await _localAuth.getAvailableBiometrics();

    if (Platform.isIOS) {
      return methods.contains(BiometricType.face)
          ? 'Face ID'
          : 'Touch ID';
    }

    // Android
    if (methods.contains(BiometricType.face)) {
      return 'Reconnaissance faciale';
    }
    return 'Empreinte digitale';
  }

  /// Déclenche la demande d'authentification biométrique et retourne
  /// `true` si l'utilisateur a été authentifié avec succès.
  Future<bool> authenticate({
    String reason = 'Authentifiez-vous pour accéder à votre espace Kora',
  }) async {
    final available = await canUseBiometrics();
    if (!available) return false;

    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        // options: const AuthenticationOptions(
        //   biometricOnly: true,
        //   stickyAuth: true,
        // ),
      );
    } on Exception {
      return false;
    }
  }
}
