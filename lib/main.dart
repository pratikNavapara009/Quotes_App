import 'package:db_qoutes_app/screens/homepage.dart';
import 'package:db_qoutes_app/screens/quotes_page.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'QuotesPage' : (context) => const QuotesPage(),
      },
    ),
  );
}
