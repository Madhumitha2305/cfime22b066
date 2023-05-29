class Character {
  final String name;
  final String birthYear;
  final String gender;
  // Add more properties as needed

  Character({
    required this.name,
    required this.birthYear,
    required this.gender,
    // Initialize additional properties here
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      birthYear: json['birth_year'],
      gender: json['gender'],
      // Map additional properties from JSON here
    );
  }
}
