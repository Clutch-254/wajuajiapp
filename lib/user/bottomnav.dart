
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mjuajiapp0/user/articalreader.dart';
import 'package:mjuajiapp0/user/chatscreen.dart';
import 'package:mjuajiapp0/user/entertainmenthub.dart';
import 'package:mjuajiapp0/user/homescreen.dart';
import 'package:mjuajiapp0/user/newsection.dart';
import 'package:mjuajiapp0/user/profilescreen.dart';



class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late HomeScreen homepage;
  late Newsection newsection;
  late ArticleReader articalreader;
  late Entertainmenthub entertainmenthub;
  late Chatscreen chatscreen;
  late Profilescreen profilescreen;

  @override
  void initState() {
    super.initState();

    homepage = const HomeScreen();
    newsection = const Newsection();
    articalreader = const ArticleReader();
    entertainmenthub = const Entertainmenthub();
    chatscreen = const Chatscreen();
    profilescreen = const Profilescreen();

    pages = [
      homepage,
      newsection,
      articalreader,
      entertainmenthub,
      chatscreen,
      profilescreen,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTabIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        index: currentTabIndex,
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.newspaper_outlined, color: Colors.white),
          Icon(Icons.menu_book_outlined, color: Colors.white),
          Icon(Icons.movie_outlined, color: Colors.white),
          Icon(Icons.chat_bubble_outline, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
      ),
    );
  }
}
