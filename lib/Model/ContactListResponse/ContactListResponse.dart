class ContactListResponse {
  List<UserContactData> data;

  ContactListResponse({this.data});

  ContactListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserContactData>[];
      json['data'].forEach((v) {
        data.add(new UserContactData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserContactData {
  int userId;
  String type;
  String name;
  String email;
  String mobile;
  String activeStatus;
  String emailVerifiedAt;
  String phoneVerifiedAt;
  String image;
  String latitude;
  String  longitude;
  int walletBalance;
  String deviceOs;
  String deviceType;
  String deviceName;
  String deviceToken;
  String createdAt;
  String updatedAt;

  UserContactData(
      {this.userId,
        this.type,
        this.name,
        this.email,
        this.mobile,
        this.activeStatus,
        this.emailVerifiedAt,
        this.phoneVerifiedAt,
        this.image,
        this.latitude,
        this.longitude,
        this.walletBalance,
        this.deviceOs,
        this.deviceType,
        this.deviceName,
        this.deviceToken,
        this.createdAt,
        this.updatedAt});

  UserContactData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    type = json['type'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    activeStatus = json['active_status'];
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    walletBalance = json['wallet_balance'];
    deviceOs = json['device_os'];
    deviceType = json['device_type'];
    deviceName = json['device_name'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['active_status'] = this.activeStatus;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['image'] = this.image;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['wallet_balance'] = this.walletBalance;
    data['device_os'] = this.deviceOs;
    data['device_type'] = this.deviceType;
    data['device_name'] = this.deviceName;
    data['device_token'] = this.deviceToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}