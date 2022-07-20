class Stats {
  final String name;
  final dynamic value;
  Stats({required this.name, required this.value});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(name: json['name'], value: json['value']);
  }
}
