class Followup {
  String? created;
  List<Null>? diet;
  String? name;
  String? status;
  String? uuid;
  List<Null>? workout;

  Followup(
      {this.created,
      this.diet,
      this.name,
      this.status,
      this.uuid,
      this.workout});

  Followup.fromJson(Map<String, dynamic> json) {
    created = json['created'];
    if (json['diet'] != null) {
      diet = <Null>[];
      json['diet'].forEach((v) {
        diet!.add(v);
      });
    }
    name = json['name'];
    status = json['status'];
    uuid = json['uuid'];
    if (json['workout'] != null) {
      workout = <Null>[];
      json['workout'].forEach((v) {
        workout!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created'] = this.created;
    if (this.diet != null) {
      data['diet'] = this.diet!.map((v) => v).toList();
    }
    data['name'] = this.name;
    data['status'] = this.status;
    data['uuid'] = this.uuid;
    if (this.workout != null) {
      data['workout'] = this.workout!.map((v) => v).toList();
    }
    return data;
  }
}