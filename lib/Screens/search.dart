import 'package:flutter/material.dart';
import 'package:movies_app/Models/movie.dart';
import 'package:movies_app/Screens/details_movie.dart';
import 'package:movies_app/Screens/home.dart';
import 'package:movies_app/services/movie_search.dart';
import 'package:page_transition/page_transition.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  List<Movie> movies = [];

  Future<List<Movie>> onSearch(query) async {
    List<Movie>? _futureMovies = await getSearch(query);
    movies = _futureMovies!;
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigator.popAndPushNamed(context, "/home");
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: Home(), type: PageTransitionType.leftToRight));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,

          // backgroundColor: Colors.grey.shade900,
          title: Container(
            height: 38,
            child: TextField(
              onChanged: (value) async {
                var result = await onSearch(value.toLowerCase());
                setState(() {
                  movies = result;
                });
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[850],
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade500,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none),
                  hintStyle:
                      TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  hintText: "Search movies"),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                try {
                  return ListTile(
                    title: Text(movies[index].title),
                    leading: Image.network(
                        "https://image.tmdb.org/t/p/original" +
                            movies[index].posterURL),
                    trailing: Wrap(children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellowAccent,
                        size: 20,
                      ),
                      Text(movies[index].voteAverage)
                    ]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return movieDetails(movie: movies[index]);
                          },
                        ),
                      );
                    },
                  );
                } catch (e) {
                  return ListTile(
                    title: Text(movies[index].title),
                  );
                }
              }),
        ),
      ),
    );
  }
}
