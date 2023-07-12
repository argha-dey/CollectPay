class ProfileDataResponse {
  ProfileData data;

  ProfileDataResponse({this.data});

  ProfileDataResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ProfileData {
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
  String longitude;
  int walletBalance;
  String deviceOs;
  String deviceType;
  String deviceName;
  String deviceToken;
  String createdAt;
  String updatedAt;

  String card_name;
  String card_no;
  String card_valid_date;
  String card_cvv;
  int card_balance;


  ProfileData(
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
        this.updatedAt,
        this.card_name,
        this.card_no,
        this.card_valid_date,
        this.card_cvv,
        this.card_balance,});

  ProfileData.fromJson(Map<String, dynamic> json) {
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
    card_name = json['card_name'];
    card_no= json['card_no'];
    card_valid_date =json['card_valid_date'];
    card_cvv= json['card_cvv'];
    card_balance = json['card_balance'];

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

    data['card_name'] =this.card_name;
    data['card_no'] =this.card_no;
    data['card_valid_date'] =this.card_valid_date;
    data['card_cvv'] =this.card_cvv;
    data['card_balance'] =this.card_balance;
    return data;
  }
}