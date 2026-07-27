import 'package:flutter/foundation.dart';

import '../web_services/biometric_service.dart';
import '../data/models/employee.dart';
import '../data/repositories/auth_repository.dart';

enum LoginStatus { idle, loading, success, error }

/// ViewModel de l'écran de connexion.
/// Expose l'état à la vue via [ChangeNotifier] (pattern Provider),
/// sans jamais manipuler de widget Flutter — c'est le rôle de la View.
class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final BiometricService _biometricService;

  LoginViewModel({
    required AuthRepository authRepository,
    required BiometricService biometricService,
  })  : _authRepository = authRepository,
        _biometricService = biometricService;

  LoginStatus status = LoginStatus.idle;
  String? errorMessage;
  Employee? employeeConnecte;
  bool biometricsDisponibles = false;
  String biometricLabel = 'Biométrie';

  Future<void> verifierDisponibiliteBiometrie() async {
    biometricsDisponibles = await _biometricService.canUseBiometrics();
    if (biometricsDisponibles) {
      biometricLabel = await _biometricService.availableMethodLabel();
    }
    notifyListeners();
  }

  Future<void> seConnecter({
    required String email,
    required String motDePasse,
  }) async {
    status = LoginStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      employeeConnecte = await _authRepository.login(
        email: email,
        password: motDePasse,
      );
      status = LoginStatus.success;
    } catch (e) {
      status = LoginStatus.error;
      errorMessage = 'Email ou mot de passe incorrect.';
    }
    notifyListeners();
  }

  /// Connexion rapide via empreinte digitale ou Face ID, pour un
  /// utilisateur déjà connecté une première fois par mot de passe.
  Future<bool> seConnecterParBiometrie() async {
    final ok = await _biometricService.authenticate(
      reason: 'Authentifiez-vous pour accéder à Kora',
    );
    if (ok) {
      status = LoginStatus.success;
      notifyListeners();
    }
    return ok;
  }
}
