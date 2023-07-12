class LoginResponseData{
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

  String active_status= "";
  String email_verified_at= "";
  String phone_verified_at= "";
  String image= "";
  String device_os= "";
  String device_type= "";
  String deleted_at= "";






  LoginResponseData.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        name = map["name"],
        email = map["email"],
        type = map["type"],
        mobile = map["mobile"],
        device_token = map["device_token"],
        latitude = map["latitude"],
        longitude = map["longitude"],
        updated_at = map["updated_at"],
        created_at = map["created_at"],


        active_status = map["active_status"],
        email_verified_at = map["email_verified_at"],
        phone_verified_at = map["phone_verified_at"],

        image = map["image"],
        device_os = map["device_os"],
        device_type = map["device_type"],
        deleted_at = map["deleted_at"];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

    data["active_status"] = active_status;
    data["email_verified_at"] = email_verified_at;
    data["phone_verified_at"] = phone_verified_at;
    data["image"] = image;
    data["device_os"]= device_os;
    data["device_type"]= device_type;
    data["deleted_at"]=deleted_at;
    return data;
  }
}