class Version {
  final int id;
  final String title;
  final String description;

  Version( {this.description, this.id, this.title});

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      id: json['id'],
      title: json['title'],
      description: json['description']
    );
  }
}
