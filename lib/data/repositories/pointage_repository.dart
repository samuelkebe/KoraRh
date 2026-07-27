import '../models/pointage.dart';

/// Abstraction de la source de données de pointage.
/// L'implémentation réelle POST /pointages vers le backend ; en cas
/// d'échec réseau, le pointage est conservé localement (voir
/// [enAttenteDeSynchronisation]) et renvoyé dès que la connexion revient.
abstract class PointageRepository {
  Future<Pointage> enregistrerPointage(Pointage pointage);
  Future<List<Pointage>> historique(String employeId, {int limit = 10});
  List<Pointage> enAttenteDeSynchronisation();
  Future<void> synchroniserEnAttente();
}

class ApiPointageRepository implements PointageRepository {
  final List<Pointage> _fileLocale = [];
  final List<Pointage> _historiqueMock = [];

  @override
  Future<Pointage> enregistrerPointage(Pointage pointage) async {
    try {
      // TODO: appel réel — await client.post('$baseUrl/pointages', ...)
      await Future.delayed(const Duration(milliseconds: 400));
      _historiqueMock.insert(0, pointage);
      return pointage;
    } catch (_) {
      // Pas de réseau : on garde le pointage en file locale, marqué
      // comme non synchronisé, pour respecter le mode hors-ligne.
      final enAttente = pointage.copyWith(synchronise: false);
      _fileLocale.add(enAttente);
      return enAttente;
    }
  }

  @override
  Future<List<Pointage>> historique(String employeId, {int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _historiqueMock.take(limit).toList();
  }

  @override
  List<Pointage> enAttenteDeSynchronisation() => List.unmodifiable(_fileLocale);

  @override
  Future<void> synchroniserEnAttente() async {
    for (final pointage in List.of(_fileLocale)) {
      // TODO: renvoyer chaque pointage au backend puis le retirer.
      _fileLocale.remove(pointage);
      _historiqueMock.insert(0, pointage.copyWith(synchronise: true));
    }
  }
}
