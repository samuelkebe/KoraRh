import '../models/employee.dart';

/// Abstraction de la source de données d'authentification.
/// L'implémentation réelle appellerait l'API REST du backend
/// (POST /auth/login) — ici on fournit une implémentation simulée
/// pour que l'app fonctionne de bout en bout sans backend branché.
abstract class AuthRepository {
  Future<Employee> login({required String email, required String password});
  Future<void> logout();
}

class ApiAuthRepository implements AuthRepository {
  // final http.Client client; // à injecter pour l'appel réseau réel

  @override
  Future<Employee> login({
    required String email,
    required String password,
  }) async {
    // TODO: remplacer par un appel réel, ex:
    // final response = await client.post(Uri.parse('$baseUrl/auth/login'),
    //   body: {'email': email, 'password': password});
    await Future.delayed(const Duration(milliseconds: 600));

    return Employee(
      id: 'emp_001',
      nomComplet: 'Awa Traoré',
      email: email,
      poste: 'Commerciale',
      equipe: 'Équipe Abidjan',
      manager: 'Koffi N\'Guessan',
      dateEntree: DateTime(2023, 3, 3),
    );
  }

  @override
  Future<void> logout() async {
    // TODO: invalider le token côté backend si nécessaire.
  }
}
