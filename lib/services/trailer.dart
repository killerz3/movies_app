import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getTrailer(vidId) async {
  String vidURL =
      'https://api.themoviedb.org/3/movie/$vidId/videos?api_key=fca313334fd49a0895e543bcae054e7e';
  final response = await http.get(Uri.parse(vidURL));
  var vidResult = json.decode(response.body);
  List trailerURLs = [];
  for (var trailer in vidResult['results']) {
    trailerURLs.add(trailer['key']);
  }
  return trailerURLs[0];
}
