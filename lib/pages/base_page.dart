import 'package:flutter/material.dart';
import 'package:github_api_demo/models/user.dart';
import 'package:github_api_demo/pages/following_page.dart';
import 'package:github_api_demo/pages/gists_page.dart';
import 'package:github_api_demo/pages/repos_page.dart';
import 'package:github_api_demo/pages/stared_page.dart';

class BasePage extends StatefulWidget {
  User user;
  BasePage({Key? key, required this.user}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  List<Widget> pages = [];
  int currIndex = 0;
  @override
  void initState() {
    pages = [
      FollowingPage(user: widget.user),
      ReposPage(user: widget.user),
      StaredPage(user: widget.user),
      GistsPage(user: widget.user)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: IconThemeData(color: Colors.black38),
        selectedIconTheme: IconThemeData(color: Colors.deepPurple),
        iconSize: 24,
        currentIndex: currIndex,
        onTap: (value) {
          setState(() {
            currIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Following"),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder_copy), label: "Repos"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Stared"),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit_document), label: "Gists"),
        ],
      ),
    );
  }
}
