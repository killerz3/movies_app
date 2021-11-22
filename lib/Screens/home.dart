import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/Screens/real_home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentScreen = 0;
  List<Widget> _screens = [realHome(), Text('search'), Text('watchlist')];

  Color GREY = Colors.grey;
  TextStyle LATO = GoogleFonts.lato();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentScreen],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        child: BottomNavyBar(
          itemCornerRadius: 90,
          selectedIndex: _currentScreen,
          onItemSelected: (index) => setState(() {
            _currentScreen = index;
          }),
          items: [
            BottomNavyBarItem(
                icon: Icon(Icons.home_rounded),
                title: Text(
                  "Home",
                  style: LATO,
                ),
                activeColor: Colors.tealAccent,
                inactiveColor: GREY),
            BottomNavyBarItem(
                icon: Icon(Icons.search_rounded),
                title: Text(
                  "Search",
                  style: LATO,
                ),
                activeColor: Colors.indigoAccent,
                inactiveColor: GREY),
            BottomNavyBarItem(
                icon: Icon(Icons.add_to_queue_rounded),
                title: Text(
                  'Watchlist',
                  style: LATO,
                ),
                inactiveColor: GREY,
                activeColor: Colors.amberAccent)
          ],
        ),
      ),
    );
  }
}
