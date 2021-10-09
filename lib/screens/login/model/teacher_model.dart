import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  int? families_count;
  Timestamp? created_at;

  TeacherModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.families_count,
  });

  TeacherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    created_at = json['created_at'];
    phone = json['phone'];
    email = json['email'];
    families_count = json['families_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['families_count'] = this.families_count;
    data['created_at'] = FieldValue.serverTimestamp();
    return data;
  }

  Map<String, dynamic> toPathJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['families_count'] = this.families_count;
    return data;
  }
}
