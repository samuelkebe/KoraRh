import 'package:flutter/foundation.dart';

import '../data/models/employee.dart';
import '../data/repositories/auth_repository.dart';

class ProfilViewModel extends ChangeNotifier {
   final AuthRepository? _authRepository;
  Employee? employee;


   ProfilViewModel({AuthRepository? authRepository, Object? employee}) : _authRepository = authRepository;

  Future<void> seDeconnecter() async {
    await _authRepository?.logout();
  }
}
