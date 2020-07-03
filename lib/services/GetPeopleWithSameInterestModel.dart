import 'dart:convert';

class GetPeopleWithSameInterestModel
{
  String name;
  String interests;
  String email;
  String phone;

  GetPeopleWithSameInterestModel({this.email, this.name, this.interests, this.phone});

  factory GetPeopleWithSameInterestModel.fromJson(Map<String, dynamic> json)
  {
    return GetPeopleWithSameInterestModel(
      email: json["email"] as String,
      interests: json["interest"].toString(),
      name: json["name"] as String,
      phone: json["phone"].toString(),
    );
  }
}