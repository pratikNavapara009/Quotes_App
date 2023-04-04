import 'dart:math';

import 'package:db_qoutes_app/Models/db_model.dart';
import 'package:db_qoutes_app/globals.dart';
import 'package:db_qoutes_app/helpers/db_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Best Quotes & Status",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        actions: const [
          Icon(
            Icons.workspace_premium,
            color: Colors.amber,
            size: 35,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.menu,
            color: Colors.black,
            size: 35,
          ),
          SizedBox(
            width: 10,
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: GridView.count(
            padding: const EdgeInsets.all(15),
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
            children: allContanier.map((e) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("QuotesPage",arguments: e);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${e['text']}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        "${e['image']}",
                        scale: 3,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              );
            }).toList()),
      ),
    );
  }
}
