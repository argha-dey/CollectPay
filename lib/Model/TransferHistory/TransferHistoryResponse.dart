class TransferHistoryResponse {
  List<TransferHistoryData> data;


  TransferHistoryResponse({this.data});

  TransferHistoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TransferHistoryData>[];
      json['data'].forEach((v) {
        data.add(new TransferHistoryData.fromJson(v));
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

class TransferHistoryData {
  int transferId;
  int fromId;
  int toId;
  From from;
  From to;
  String amount;
  String createdAt;
  String updatedAt;

  TransferHistoryData(
      {this.transferId,
        this.fromId,
        this.toId,
        this.from,
        this.to,
        this.amount,
        this.createdAt,
        this.updatedAt});

  TransferHistoryData.fromJson(Map<String, dynamic> json) {
    transferId = json['transfer_id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    to = json['to'] != null ? new From.fromJson(json['to']) : null;
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transfer_id'] = this.transferId;
    data['from_id'] = this.fromId;
    data['to_id'] = this.toId;
    if (this.from != null) {
      data['from'] = this.from.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to.toJson();
    }
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class From {
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
  String cardName;
  String cardNo;
  String cardValidDate;
  String cardCvv;
  int cardBalance;
  String deviceOs;
  String deviceType;
  String deviceName;
  String deviceToken;
  String createdAt;
  String updatedAt;

  From(
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
        this.cardName,
        this.cardNo,
        this.cardValidDate,
        this.cardCvv,
        this.cardBalance,
        this.deviceOs,
        this.deviceType,
        this.deviceName,
        this.deviceToken,
        this.createdAt,
        this.updatedAt});

  From.fromJson(Map<String, dynamic> json) {
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
    cardName = json['card_name'];
    cardNo = json['card_no'];
    cardValidDate = json['card_valid_date'];
    cardCvv = json['card_cvv'];
    cardBalance = json['card_balance'];
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
    data['card_name'] = this.cardName;
    data['card_no'] = this.cardNo;
    data['card_valid_date'] = this.cardValidDate;
    data['card_cvv'] = this.cardCvv;
    data['card_balance'] = this.cardBalance;
    data['device_os'] = this.deviceOs;
    data['device_type'] = this.deviceType;
    data['device_name'] = this.deviceName;
    data['device_token'] = this.deviceToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
