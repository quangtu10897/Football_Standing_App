class Logo {
  final String href;

  Logo({required this.href});

  factory Logo.fromJson(Map<String, dynamic> json) {
    return Logo(
      href: json['href'],
    );
  }
}
