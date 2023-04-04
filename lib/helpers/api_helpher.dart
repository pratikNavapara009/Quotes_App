import 'dart:convert';
import 'dart:typed_data';
import 'package:db_qoutes_app/Models/db_model.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<List<Quotes>?> fetchQuotes() async {
    http.Response res = await http.get(
      Uri.parse("https://api.quotable.io/quotes/?author"),
    );

    if (res.statusCode == 200) {
      Map data = jsonDecode(res.body);
      List results = data["results"];
      List<Uint8List> images = [];

      for (int i = 0; i < results.length; i++) {
        http.Response image = await http.get(
          Uri.parse("https://source.unsplash.com/random"),
        );
        if (res.statusCode == 200) {
          images.add(image.bodyBytes);
        }
      }
      List<Quotes> quotesList = results
          .map((e) => Quotes.fromMap(e, images[results.indexOf(e)]))
          .toList();
      print(quotesList);
      return quotesList;
    }
    return null;
  }
}
