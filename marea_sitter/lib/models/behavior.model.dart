class Behavior {
  final int id;
  final String title;
  final String description;

  Behavior( {this.description, this.id, this.title});

  factory Behavior.fromJson(Map<String, dynamic> json) {
    return Behavior(
      id: json['id'],
      title: json['title'],
      description: json['description']
    );
  }
}
