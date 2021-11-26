import 'package:flutter/material.dart';
import 'package:movies_app/Models/movie.dart';

class movieDetails extends StatefulWidget {
  final Movie movie;
  const movieDetails({Key? key,required this.movie}) : super(key: key);

  @override
  _movieDetailsState createState() => _movieDetailsState();
}

class _movieDetailsState extends State<movieDetails> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(height: 300,width: 300,color: Colors.tealAccent,child:Text(widget.movie.title) ,),);
  }
}
