import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:safarkarappfyp/database/userLocalData.dart';

class SuggestPlacesFromAPI {
  void getSuggestion() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://127.0.0.1:5050/lang'));
    request.body = json.encode({"userId": "JJS6n56BUXOSnCe0j0WKIpiuNPf1"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
// print('Response status: ${response.statusCode}');
// print('Response body: ${response.body}');

// print(await http.read('https://example.com/foobar.txt'));
}
