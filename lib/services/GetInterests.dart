class GetInterest
{
  String interest;

  GetInterest({this.interest});

  factory GetInterest.fromJson(Map<String, dynamic> json)
  {
    return GetInterest(
      interest: json["interest"] as String
    );
  }
}