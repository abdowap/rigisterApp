class Profile {
  int? id;
  String? name;
  int? age;
  String? note;

  Profile({this.id, this.name, this.age, this.note});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['age'] = this.age;
    data['note'] = this.note;
    return data;
  }
}
