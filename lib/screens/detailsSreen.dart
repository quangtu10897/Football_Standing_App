import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String name;
  final String href;
  const DetailsScreen({Key? key, required this.name, required this.href})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details Screen'),
          backgroundColor: Colors.blue[700],
          elevation: 0,
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.href),
                  backgroundColor: Colors.white,
                  radius: 70,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Season 2021",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text('data'),
              Text('data'),
              Text('data'),
              Text('data'),
              Text('data'),
            ])));
  }
}
