import 'package:flutter/foundation.dart';

import 'logo.dart';

class Team {
  final String name;
  final String shortName;
  final List<Logo> logo;

  Team({required this.name, required this.shortName, required this.logo});

  factory Team.fromJson(Map<String, dynamic> json) {
     List<dynamic> listLogo = json['logos'];

    return Team(
      name: json['name'],
      shortName: json['shortDisplayName'],
      logo: listLogo.map<Logo>((item) => Logo.fromJson(item)).toList(),
    );
  }
}
