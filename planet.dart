class Planet {
  final String name;
  final String climate;
  final String population;
  // Add more properties as needed

  Planet({
    required this.name,
    required this.climate,
    required this.population,
    // Initialize additional properties here
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'],
      climate: json['climate'],
      population: json['population'],
      // Map additional properties from JSON here
    );
  }
}
