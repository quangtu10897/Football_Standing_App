import 'stats.dart';
import 'team.dart';
import 'note.dart';

class Standing {
   final Team team;
   final List<Stats>? stats;
  final Note? note;

  Standing({required this.team,required this.stats,required this.note});

  factory Standing.fromJson(Map<String, dynamic> json) {
    List<dynamic> listStats = json['stats'];
    return Standing(
          team: Team.fromJson(json['team']),
          note: json['note'] != null ? Note.fromJson(json['note']) : null,
          stats: listStats.map<Stats>((item) => Stats.fromJson(item)).toList(),
    
    );
    
     
  }
}
