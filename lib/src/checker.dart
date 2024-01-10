import 'package:flutter/material.dart';
import 'package:golden_maze/src/white/initial_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'black/black.dart';

class Checker extends StatelessWidget {
  const Checker({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child: PageChecker(),
        ),
      );
  }
}

class PageChecker extends StatefulWidget {
  @override
  _PageCheckerState createState() => _PageCheckerState();
}

class _PageCheckerState extends State<PageChecker> {

  @override
  void initState() {
    super.initState();
    _checkPage();
  }

  Future<void> _checkPage() async {
    const url = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        prefs.setString("state", "black");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WebViewApp()));
      } else  {
        throw Exception();
      }
    } catch (e) {
      print(e);
      prefs.setString("state", "white");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InitialPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
