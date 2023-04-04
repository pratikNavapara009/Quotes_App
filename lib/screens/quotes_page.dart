import 'package:db_qoutes_app/Models/db_model.dart';
import 'package:db_qoutes_app/helpers/db_helper.dart';
import 'package:flutter/material.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  @override
  Widget build(BuildContext context) {
    Map e = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${e['text']}",
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: FutureBuilder(
        future: DBHelper.dbHelper.fetchAllRecords(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<DBQuotes>? data = snapshot.data as List<DBQuotes>?;
            return (data != null)
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: const EdgeInsets.all(20),
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(
                              data[i].image,
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Text(data[i].quotes),
                                const Spacer(),
                                Text(data[i].author),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          } else {
            return const Center(
              child: Text("No Data Found...!!!"),
            );
          }
        },
      ),
    );
  }
}
