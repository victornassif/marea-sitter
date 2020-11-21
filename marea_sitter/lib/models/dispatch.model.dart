class Dispatch {
  int id;
  int versionId;
  List<int> behaviorIds;
  DateTime date;
  int quantity;
  int destinyId;

  Dispatch(
      {this.id,
      this.date,
      this.quantity,
      this.versionId,
      this.behaviorIds,
      this.destinyId});

  factory Dispatch.fromJson(Map<String, dynamic> json) {
    
    var id =  json['id'];
    var date =  DateTime.parse(json['date']);
    var quantity =  json['quantity'];
    var versionId =  json['versionId'];
    return Dispatch(
      id: id,
      date: date,
      quantity: quantity,
      versionId: versionId
    );
  }
}
