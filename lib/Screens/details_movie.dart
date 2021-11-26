
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/Models/movie.dart';
import 'package:movies_app/services/trailer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class movieDetails extends StatefulWidget {
  final Movie movie;
  const movieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  _movieDetailsState createState() => _movieDetailsState();
}

class _movieDetailsState extends State<movieDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              // backgroundColor: Colors.grey[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                  title: AutoSizeText(
                    widget.movie.title,
                    style: GoogleFonts.lato(
                      color: Colors.grey[300],
                    ),
                  ),
                  // titlePadding: EdgeInsets.all(30),
                  background: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/original" +
                                  widget.movie.backdropURL),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              Colors.grey.withOpacity(0.0),
                              Colors.black
                            ],
                            stops: const [
                              0.0,
                              1.0
                            ]),
                      ),
                    ),
                  )),
            ),
            buildBody(widget.movie),
          ],
        ),
      ),
    );
  }
}

Widget ytPlayer(Movie movie) => Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 7),
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1.5,
                blurRadius: 9)
          ],
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: Colors.grey[900]),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: FutureBuilder(
            future: getTrailer(movie.id),
            builder: (context, snapshot) {
              if (ConnectionState.active != null && !snapshot.hasData) {
                return const Center(
                    child: SpinKitWave(
                  color: Colors.tealAccent,
                  size: 100,
                ));
              } else {
                YoutubePlayerController _controller = YoutubePlayerController(
                  initialVideoId: snapshot.data.toString(),

                  params: const YoutubePlayerParams(
                    showFullscreenButton: true,
                    autoPlay: false,
                    showVideoAnnotations: false,
                    desktopMode: true,
                  ),

                  // hideTopMenu:true,
                );

                _controller.hideTopMenu();

                _controller.hideTopMenu;

                _controller.hidePauseOverlay;

                return YoutubePlayerIFrame(
                  controller: _controller,
                  aspectRatio: 16 / 9,
                );
              }
            }),
      ),
    );

Widget buildBody(Movie movie) => SliverToBoxAdapter(
        child: SingleChildScrollView(
            child: Container(
      // height: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            titleRow(movie),
            const SizedBox(height: 20),
            description(movie),
            const SizedBox(height: 20),
            ytPlayer(movie),
          ],
        ),
      ),
    )));

Widget titleRow(movie) {
  return Row(
    children: [
      Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
              offset: Offset(0, 7),
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1.5,
              blurRadius: 9)
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Image.network(
            "https://image.tmdb.org/t/p/original" + movie.posterURL,
            height: 200,
          ),
        ),
      ),
      const SizedBox(width: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: AutoSizeText(movie.title,
                maxLines: 2,
                style:
                    GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 38))),
          ),
          SizedBox(height: 10),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.star,
                color: Colors.yellowAccent,
              ),
              SizedBox(width: 5),
              Text(
                movie.voteAverage == '0.0' ? "Unavailable" : movie.voteAverage,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text("Release Date :  ${movie.release}",style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 16)),),
        ],
      ),
    ],
  );
}

Widget description(movie) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 7),
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1.5,
              blurRadius: 9)
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.grey[900]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[800]),
            child: Text('Synopsis',
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(fontSize: 28),
                    letterSpacing: 2))),
        const SizedBox(height: 5),
        AutoSizeText(
          movie.about,
          style: GoogleFonts.lato(
              textStyle: TextStyle(fontSize: 21, letterSpacing: 1.5)),
        ),
      ],
    ),
  );
}
