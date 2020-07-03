import 'dart:convert';

import 'package:evento/ConstantUrls.dart';
import 'package:evento/services/GetPeopleWithSameInterestModel.dart';
import 'package:http/http.dart' as http;


class GetPeopleWithSameInterestData
{
  static Future<List<GetPeopleWithSameInterestModel>> getPeopleWithSameInterestData({id}) async
  {
    final response = await http.post(ConstantUrls.GetPeopleWithSameInterestsUrl, body:
                     {
                       "verify" : "TheCandidoVirtualEvent2020",
                       "txtUserId" : id.toString(),
                     });

    print("RESPONSE : " + response.body);

    List<GetPeopleWithSameInterestModel> people = parsePeople(response.body);

    return people;
  }

  static List<GetPeopleWithSameInterestModel> parsePeople(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<GetPeopleWithSameInterestModel>((json) => GetPeopleWithSameInterestModel.fromJson(json)).toList();
  }
}