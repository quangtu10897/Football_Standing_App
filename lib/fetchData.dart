import 'models/football.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:async';

Future<List<Football>> fetchData() async {
  var client = http.Client();
  List<Football> lstFootball = [];
  var apiStanding =
      "https://api-football-standings.azharimm.site/leagues/eng.1/standings?season=2020";
  try {
    var response = await client.get(Uri.parse(apiStanding));
    var fbs = Football.fromJson(jsonDecode(response.body));
    Football football = fbs;
    //Data data = fbs.data;
    //print("DATA =>> ${data.standings![2].stats![6].value}");
    ////print(football.data.standings![10].team.name);
    lstFootball.add(football);
    //Rprint(football.data.standings![0].team.name);
    return lstFootball;
  } finally {
    client.close();
  }
}
