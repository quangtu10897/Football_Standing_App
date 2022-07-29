import 'models/football.dart';
import 'package:dio/dio.dart';
import 'dart:async';

Future<List<Football>> fetchData(String url) async {
  List<Football> lstFootball = [];
  var apiStanding =
      'https://api-football-standings.azharimm.site/leagues/eng.1/standings?season=$url';
  try {
    var response = await Dio().get(apiStanding);
    var fbs = Football.fromJson(response.data);
    Football football = fbs;
    lstFootball.add(football);
    return lstFootball;
  } 
  on DioError catch (e) {
    print(e.message);
    throw Exception(e.message);
  }
}
