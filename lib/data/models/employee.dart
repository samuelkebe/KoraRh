class Employee {
  final String id;
  final String nomComplet;
  final String email;
  final String poste;
  final String equipe;
  final String manager;
  final DateTime dateEntree;

  const Employee({
    required this.id,
    required this.nomComplet,
    required this.email,
    required this.poste,
    required this.equipe,
    required this.manager,
    required this.dateEntree,
  });

  String get initiales {
    final parts = nomComplet.trim().split(' ');
    if (parts.length < 2) return nomComplet.substring(0, 1).toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as String,
      nomComplet: json['nom_complet'] as String,
      email: json['email'] as String,
      poste: json['poste'] as String,
      equipe: json['equipe'] as String,
      manager: json['manager'] as String,
      dateEntree: DateTime.parse(json['date_entree'] as String),
    );
  }
}
