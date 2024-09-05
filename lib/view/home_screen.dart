import 'package:flutter/material.dart';
import 'package:hindi_news/model/news_model.dart';
import 'package:hindi_news/view/headlines_screen.dart';
import 'package:hindi_news/view/saved_news_screen.dart';
import 'package:hindi_news/view/search_screen.dart';


class HomeScreen extends StatefulWidget {

   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(initialPage: 0);
  late int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PageView(
        controller: pageController,
        children: const <Widget>[
          Center(
            child: HeadlinesScreen(),
          ),
          Center(
            child: SearchScreen(),
          ),
          Center(
            child: SavedNewsScreen(),
          ),


        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            pageController.jumpToPage(index);
          });
        },
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_add_outlined),
            label: 'Saved',
          ),

        ],
      ),
    );
  }
}
