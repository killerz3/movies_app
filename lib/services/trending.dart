import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/Models/movie.dart';

Future<List<Movie>?> getTrending() async {
  bool adult;
  String backdropURL;
  String posterURL;
  String title;
  String about;
  double voteAverage;
  DateTime release;

  String discoverURL =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=fca313334fd49a0895e543bcae054e7e';

  final response = await http.get(Uri.parse(discoverURL));
  var result = json.decode(response.body);
  // print(result);
  List<Movie> movies = [];
  for (var singleMovie in result["results"]) {
    Movie movie = Movie(
        about: singleMovie['overview'],
        adult: singleMovie['adult'],
        backdropURL: singleMovie["backdrop_path"],
        posterURL: singleMovie['poster_path'],
        release: singleMovie['release_date'],
        title: singleMovie['title'],
        voteAverage: singleMovie['vote_average'].toString());

    movies.add(movie);
  }

  return movies;
}

Future<List<Movie>> getTopTen() async {
  List<Movie>? trending = await getTrending();
  List<Movie> topTen = [];
  for (int i = 0; i < 10; i++) {
    topTen.add(trending![i]);
  }
  return topTen;
}
