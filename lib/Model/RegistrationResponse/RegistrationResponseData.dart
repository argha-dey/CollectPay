class RegistrationResponseData{
  int id;
  String name= "";
  String email= "";
  String type= "";
  String mobile= "";
  String device_token= "";
  String device_name= "";
  String latitude= "";
  String longitude= "";
  String updated_at= "";
  String created_at= "";



  RegistrationResponseData.fromJsonMap(Map<dynamic, dynamic> map):
        id = map["id"],
        name = map["name"],
        email = map["email"],

  type = map["type"],
  mobile = map["mobile"],
  device_token = map["device_token"],

  latitude = map["latitude"],
  longitude = map["longitude"],
  updated_at = map["updated_at"],
  created_at = map["created_at"];


  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
     data["id"] = id;
     data["name"] = name;
     data["email"] = email;
      data["type"] = type;
     data["mobile"] = mobile;
      data["device_token"] = device_token;
      data["latitude"] = latitude;
      data["longitude"]= longitude;
      data["updated_at"]= updated_at;
      data["created_at"]=created_at;
    return data;
  }
}