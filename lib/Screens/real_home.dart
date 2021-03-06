import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/Models/movie.dart';
import 'package:movies_app/Screens/details_movie.dart';
import 'package:movies_app/services/trending.dart';

class realHome extends StatefulWidget {
  const realHome({Key? key}) : super(key: key);

  @override
  _realHomeState createState() => _realHomeState();
}

class _realHomeState extends State<realHome> {
  Color GREY = Colors.grey;
  TextStyle LATO = GoogleFonts.lato();
  List<Movie> movies = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movie Mania",
          style: GoogleFonts.lato(
              color: Colors.tealAccent,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              wordSpacing: 1),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        centerTitle: true,
        elevation: 3,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Icon(Icons.trending_up_rounded),
              SizedBox(width: 10),
              Text(
                "Trending",
                style: GoogleFonts.lato(
                  color: Colors.grey[400],
                  fontSize: 32,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: carousel(),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
              flex: 7,
              child: FutureBuilder(
                  future: getTrending(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    // WHILE THE CALL IS BEING MADE AKA LOADING
                    if (ConnectionState.active != null && !snapshot.hasData) {
                      return const Center(
                          child: SpinKitWave(
                        color: Colors.tealAccent,
                        size: 100,
                      ));
                    } else {
                      return ListView.builder(
                          cacheExtent: 9999,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
                                padding: EdgeInsets.only(bottom: 20),
                                child: ListTile(
                                  title: Text(snapshot.data[index].title),
                                  leading: Image.network(
                                      "https://image.tmdb.org/t/p/original" +
                                          snapshot.data[index].posterURL),
                                  trailing: Wrap(children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellowAccent,
                                      size: 20,
                                    ),
                                    Text(snapshot.data[index].voteAverage)
                                  ]),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return movieDetails(
                                              movie: snapshot.data[index]);
                                        },
                                      ),
                                    );
                                  },
                                ));
                          });
                    }
                  })),
        ],
      ),
    );
  }
}

class carousel extends StatefulWidget {
  const carousel({
    Key? key,
  }) : super(key: key);

  @override
  State<carousel> createState() => _carouselState();
}

class _carouselState extends State<carousel> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getTopTen(),
        builder: (context, AsyncSnapshot snapshot) {
          if (ConnectionState.active != null && !snapshot.hasData) {
            return const Center(
                child: SpinKitWave(
              color: Colors.tealAccent,
              size: 100,
            ));
          } else {
            // ignore: dead_code
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: CarouselSlider.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index, realIndex) {
                  return MovieCard(snapshot.data[index], index, context);
                },
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 500),
                    autoPlayCurve: Curves.bounceInOut,
                    pauseAutoPlayOnTouch: true,
                    enlargeCenterPage: true),
              ),
            );
          }
        });
  }
}

Widget MovieCard(Movie movie, int index, context) => GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return movieDetails(movie: movie);
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1.5,
                        offset: Offset(0, 7),
                        blurRadius: 9)
                  ],
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      "https://image.tmdb.org/t/p/original" + movie.backdropURL,
                    ),
                  )),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [Colors.grey.withOpacity(0.0), Colors.black],
                      stops: const [0.0, 1.0]),
                ),
              )),
          Positioned(
            bottom: 0,
            left: 10,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(0, 7),
                            spreadRadius: 3,
                            blurRadius: 2)
                      ]),
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                        imageUrl: "https://image.tmdb.org/t/p/original" +
                            movie.posterURL,
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 10,
                        maxWidth: 200,
                      ),
                      child: AutoSizeText(
                        movie.title,
                        maxLines: 2,
                        style: TextStyle(fontSize: 18),
                        maxFontSize: 32,
                      ),
                    ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,

                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellowAccent,
                        ),
                        Text(movie.voteAverage == '0.0'
                            ? "Unavailable"
                            : movie.voteAverage),
                      ],
                    ),
                    Text(movie.release),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
