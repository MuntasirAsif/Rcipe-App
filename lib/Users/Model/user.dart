import 'dart:convert';

class User{
  int user_id;
  String user_name;
  String user_email;
  String user_password;
  User(
      this.user_id,
      this.user_name,
      this.user_email,
      this.user_password,
      );
  factory User.fromJson(Map<String,dynamic>json)=>User(
  int.parse(json["USER_ID"]),
  json["USER_NAME"],
  json["EMAIL"],
  json["PASSWORD"],
  );
  Map<String,dynamic>toJson()=>{
    'user_id':user_id.toString(),
    'user_name':user_name,
    'user_email':user_email,
    'user_Password':user_password,
  };
}