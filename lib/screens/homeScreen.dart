import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/fetchData.dart';
import 'package:project_flutter/models/football.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'list_team.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownValue = '2021';
  late SharedPreferences prefs;
  final _key = 'season';
  @override
  void initState() {
    super.initState();
    _getSeason();
  }

  _getSeason() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      final seasonValue = prefs.getString(_key);
      if (seasonValue != null) {
        dropdownValue = seasonValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(CupertinoIcons.search),
        ],
        title: Text(tr('English Premire League')),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: Column(
        children: [
          Text(
            tr("Seasons"),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            elevation: 0,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) async {
              setState(() {
                dropdownValue = newValue!;
              });
              prefs.setString(_key, dropdownValue);
            },
            items: <String>['2021', '2020', '2019', '2018', '2017', '2016']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          // TextField(
          //   decoration: const InputDecoration(
          //       labelText: 'Search', suffixIcon: Icon(Icons.search)),
          // ),

          Expanded(
            child: FutureBuilder<List<Football>>(
                future: fetchData(dropdownValue),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred!'),
                    );
                  } else if (snapshot.hasData) {
                    return FootBallList(
                      lstFootball: snapshot.data!,
                      lstStanding: snapshot.data![0].data.standings!,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

