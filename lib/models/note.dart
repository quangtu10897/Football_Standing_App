class Note {
  final int rank;
  Note({required this.rank});

  factory Note.fromJson(Map<String, dynamic> json) {
    return (Note(rank: json['rank']));
  }
}
