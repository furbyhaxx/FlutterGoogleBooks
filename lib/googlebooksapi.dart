import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GoogleBooksApi {
  // static final String _url = "https://www.googleapis.com/books/v1/volumes";
  static const String _url = 'www.googleapis.com';
  static const String _path = '/books/v1/volumes';

  GoogleBooksApi();

  Future<void> search({String q = "", String author = "Dennis", String title = ""}) async {
    var url = Uri.https(_url, _path, {
      'q': q,
      'intitle': title,
      'inauthor': author
    });

    print(url);

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['totalItems'];
      print('Number of books about $q: $itemCount.');
      print(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
