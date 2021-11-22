//The result from the api looks like
/*

            "adult": false,
            "backdrop_path": "/cinER0ESG0eJ49kXlExM0MEWGxW.jpg",
            "genre_ids": [
                28,
                12,
                14
            ],
            "id": 566525,
            "original_language": "en",
            "original_title": "Shang-Chi and the Legend of the Ten Rings",
            "overview": "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization.",
            "popularity": 7750.478,
            "poster_path": "/1BIoJGKbXjdFDAqUEiA2VHqkK1Z.jpg",
            "release_date": "2021-09-01",
            "title": "Shang-Chi and the Legend of the Ten Rings",
            "video": false,
            "vote_average": 7.9,
            "vote_count": 3181
*/

class Movie {
  bool adult;
  String backdropURL;
  String posterURL;
  String title;
  String about;
  var voteAverage;
  String release;

  Movie(
      {required this.about,
      required this.adult,
      required this.backdropURL,
      required this.posterURL,
      required this.release,
      required this.title,
      required this.voteAverage});
}
