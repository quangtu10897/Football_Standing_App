import 'models/football.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/data.dart';
import 'dart:async';
import 'fetchData.dart';


void main() async {
  List<Football> listFootball = await fetchData();
  for (int i = 0; i < listFootball[0].data.standings!.length; i++) {
    print(listFootball[0].data.standings![i].team.name+'===>'+listFootball[0].data.standings![i].team.logo[0].href);
    }
}
