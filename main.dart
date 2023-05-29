import 'package:flutter/material.dart';
import 'character.dart';
import 'swapi_service.dart';
import 'planet.dart';
import 'movie.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Character>> characters;
  late Future<List<Planet>> planets;
  late Future<List<Movie>> movies;


  @override
  void initState() {
    super.initState();
    characters = SwapiService.fetchData('https://swapi.dev/api/people/')
        .then((data) => parseCharacters(data));
    planets = SwapiService.fetchData('https://swapi.dev/api/planets/')
        .then((data) => parseCharacters(data));
    movies = SwapiService.fetchData('https://swapi.dev/api/films/')
        .then((data) => parseCharacters(data));
    }
  }

  List<Character> parseCharacters(dynamic data) {
    final List<dynamic> results = data['results'];
    return results.map((json) => Character.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Wars Characters'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Character>>(
              future: characters,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<Character> characterList = snapshot.data!;
                  return ListView.builder(
                    itemCount: characterList.length,
                    itemBuilder: (context, index) {
                      final Character character = characterList[index];
                      return ListTile(
                        title: Text(character.name),
                        subtitle: Text('Birth Year: ${character.birthYear}'),
                        trailing: Text('Gender: ${character.gender}'),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Planet>>(
              future: planets,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<Planet> planetList = snapshot.data!;
                  return ListView.builder(
                    itemCount: planetList.length,
                    itemBuilder: (context, index) {
                      final Planet planet = planetList[index];
                      return ListTile(
                        title: Text(planet.name),
                        subtitle: Text('Climate: ${planet.climate}'),
                        trailing: Text('Population: ${planet.population}'),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Movie>>(
              future: movies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<Movie> movieList = snapshot.data!;
                  return ListView.builder(
                    itemCount: movieList.length,
                    itemBuilder: (context, index) {
                      final Movie movie = movieList[index];
                      return ListTile(
                        title: Text(movie.title),
                        subtitle: Text('Director: ${movie.director}'),
                        trailing: Text('Release Date: ${movie.releaseDate}'),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


