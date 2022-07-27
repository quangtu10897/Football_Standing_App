import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/fetchData.dart';
import 'package:project_flutter/models/football.dart';
import 'package:project_flutter/models/standing.dart';
import 'package:project_flutter/screens/detailsSreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                    return FootBallList(lstFootball: snapshot.data!);
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

class FootBallList extends StatefulWidget {
  FootBallList({super.key, required this.lstFootball});
  List<Football> lstFootball;

  @override
  State<FootBallList> createState() => _FootBallListState();
}

class _FootBallListState extends State<FootBallList> {
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(tr('Rank')),
              const SizedBox(
                width: 50,
              ),
              Text(tr('Name')),
              SizedBox(width: 187),
              Text(tr("Point")),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.lstFootball[0].data.standings!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsScreen(
                              name: widget.lstFootball[0].data.standings![index]
                                  .team.name,
                              href: widget.lstFootball[0].data.standings![index]
                                  .team.logo[0].href,
                              points: widget.lstFootball[0].data
                                  .standings![index].stats![6].value,
                              goals: widget.lstFootball[0].data
                                  .standings![index].stats![4].value,
                              ties: widget.lstFootball[0].data.standings![index]
                                  .stats![2].value,
                              wins: widget.lstFootball[0].data.standings![index]
                                  .stats![0].value,
                              loss: widget.lstFootball[0].data.standings![index]
                                  .stats![1].value,
                              rank: widget.lstFootball[0].data.standings![index]
                                  .stats![8].value,
                              goalConceded: widget.lstFootball[0].data
                                  .standings![index].stats![5].value,
                              goalDif: widget.lstFootball[0].data
                                  .standings![index].stats![9].value,
                              season: widget.lstFootball[0].data.season,
                            ),
                          ));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text('${index + 1}'),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(widget.lstFootball[0]
                                .data.standings![index].team.logo[0].href),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(widget
                              .lstFootball[0].data.standings![index].team.name),
                          Expanded(
                            child: Text(
                              '${widget.lstFootball[0].data.standings![index].stats![6].value}',
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                  // Card(
                  //   child: ListTile(
                  //     onTap: () {
                  //       Navigator.pushNamed(context, '/detailsScreen');
                  //     },
                  //     title:
                  //         Text(lstFootball[0].data.standings![index].team.name),
                  //     leading: CircleAvatar(
                  //         backgroundColor: Colors.white,
                  //         backgroundImage: NetworkImage(lstFootball[0]
                  //             .data
                  //             .standings![index]
                  //             .team
                  //             .logo[0]
                  //             .href)),
                  //   ),
                  // );
                }),
          ),
        ),
      ],
    );
  }
}
