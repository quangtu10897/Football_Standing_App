import 'models/football.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:async';

Future<List<Football>> fetchData(String url) async {
  var data = [];
  var client = http.Client();
  List<Football> lstFootball = [];
  var apiStanding =
      "https://api-football-standings.azharimm.site/leagues/eng.1/standings?season=$url";
  try {
    var response = await client.get(Uri.parse(apiStanding));
    var fbs = Football.fromJson(jsonDecode(response.body));
    Football football = fbs;
    lstFootball.add(football);
    return lstFootball;
  } finally {
    client.close();
  }
  
}
