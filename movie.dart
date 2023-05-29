class Movie {
  final String title;
  final String director;
  final String releaseDate;
  // Add more properties as needed

  Movie({
    required this.title,
    required this.director,
    required this.releaseDate,
    // Initialize additional properties here
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      director: json['director'],
      releaseDate: json['release_date'],
      // Map additional properties from JSON here
    );
  }
}
