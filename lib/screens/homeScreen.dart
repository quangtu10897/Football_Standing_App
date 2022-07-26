import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/fetchData.dart';
import 'package:project_flutter/models/football.dart';
import 'package:project_flutter/screens/detailsSreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownValue = '2021';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(CupertinoIcons.search),
        ],
        title: Text('English Premire League'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: Column(
        children: [
          Text(
            "Seasons",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 0,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['2021', '2020', '2019', '2018', '2017', '2016']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
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

class FootBallList extends StatelessWidget {
  const FootBallList({super.key, required this.lstFootball});
  final List<Football> lstFootball;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text('Rank'),
              const SizedBox(
                width: 50,
              ),
              Text('Name'),
              SizedBox(width: 187),
              Text("Point"),
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
                itemCount: lstFootball[0].data.standings!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsScreen(
                              name: lstFootball[0]
                                  .data
                                  .standings![index]
                                  .team
                                  .name,
                              href: lstFootball[0]
                                  .data
                                  .standings![index]
                                  .team
                                  .logo[0]
                                  .href,
                              points: lstFootball[0]
                                  .data
                                  .standings![index]
                                  .stats![6]
                                  .value,
                              goals: lstFootball[0]
                                  .data
                                  .standings![index]
                                  .stats![4]
                                  .value,
                              ties: lstFootball[0]
                                  .data
                                  .standings![index]
                                  .stats![2]
                                  .value,
                              wins: lstFootball[0]
                                  .data
                                  .standings![index]
                                  .stats![0]
                                  .value,
                              loss: lstFootball[0]
                                  .data
                                  .standings![index]
                                  .stats![1]
                                  .value,
                              rank: lstFootball[0]
                                  .data
                                  .standings![index]
                                  .stats![8]
                                  .value,
                              goalConceded: lstFootball[0]
                                  .data
                                  .standings![index]
                                  .stats![5]
                                  .value,
                              goalDif: lstFootball[0]
                                  .data
                                  .standings![index]
                                  .stats![9]
                                  .value,
                              season: lstFootball[0].data.season,
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
                            backgroundImage: NetworkImage(lstFootball[0]
                                .data
                                .standings![index]
                                .team
                                .logo[0]
                                .href),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(lstFootball[0].data.standings![index].team.name),
                          Expanded(
                            child: Text(
                              '${lstFootball[0].data.standings![index].stats![6].value}',
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
