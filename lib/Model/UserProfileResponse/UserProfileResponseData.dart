

class UserProfileResponseData {
  String id;
  String name;
  String email_id;
  String mobile_no;
  String profile_pic;

  UserProfileResponseData({

    this.id,
    this.name,
    this.email_id,
    this.mobile_no,
    this.profile_pic,

  });

  factory UserProfileResponseData.fromJson(Map<String, dynamic> parsedJson){

    return UserProfileResponseData(
      id: parsedJson['id'],
      name: parsedJson['name'],
      email_id: parsedJson['email_id'],
      mobile_no: parsedJson['mobile_no'],
      profile_pic: parsedJson['profile_pic'],
    );
  }


}