enum TypePointage { entree, sortie }

class Pointage {
  final String id;
  final String employeId;
  final DateTime heure;
  final TypePointage type;
  final double latitude;
  final double longitude;
  final bool synchronise; // false = en attente de synchronisation (offline)

  const Pointage({
    required this.id,
    required this.employeId,
    required this.heure,
    required this.type,
    required this.latitude,
    required this.longitude,
    this.synchronise = true,
  });

  Pointage copyWith({bool? synchronise}) {
    return Pointage(
      id: id,
      employeId: employeId,
      heure: heure,
      type: type,
      latitude: latitude,
      longitude: longitude,
      synchronise: synchronise ?? this.synchronise,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'employe_id': employeId,
        'heure': heure.toIso8601String(),
        'type': type.name,
        'latitude': latitude,
        'longitude': longitude,
      };
}
