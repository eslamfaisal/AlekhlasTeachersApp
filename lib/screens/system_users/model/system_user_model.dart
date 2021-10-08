import 'package:cloud_firestore/cloud_firestore.dart';

class SystemUserModel {
  String? id;
  String? name;
  String? email;
  bool? is_super_admin;
  String? password;
  List<String>? roles = [];

  SystemUserModel({this.id, this.is_super_admin, this.name, this.email, this.password, this.roles});

  SystemUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    is_super_admin = json['is_super_admin'];
    if (json['roles'] != null) roles = List.from(json['roles']);
  }

  Map<String, dynamic> toJson({bool withCreatedAt = true}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['is_super_admin'] = this.is_super_admin;
    data['roles'] = this.roles;
    if(withCreatedAt)
    data['created_at'] = FieldValue.serverTimestamp();
    return data;
  }

  SystemUserModel.initial() {
    this.id = "";
  }
}
