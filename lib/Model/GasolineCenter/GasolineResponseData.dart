class GasolineResponseData {
  List<GasolineData> data;


  GasolineResponseData({this.data,});

  GasolineResponseData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GasolineData>[];
      json['data'].forEach((v) {
        data.add(new GasolineData.fromJson(v));
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

class GasolineData {
  int shopId;
  int userId;
  int shopDisplayId;
  String shopName;
  String shopAddress;
  String latitude;
  String longitude;
  String shopRegistrationNo;
  String shopRegistrationDoc;
  String shopPhoto;
  String openingTime;
  String closingTime;
  String closingMessage;
  String holidayMessage;
  String shopDescription;
  String activeStatus;
  String createdAt;
  String updatedAt;
  String shopRating;
  List<ItemPrice> itemPrice;


  GasolineData(
      {this.shopId,
        this.userId,
        this.shopDisplayId,
        this.shopName,
        this.shopAddress,
        this.latitude,
        this.longitude,
        this.shopRegistrationNo,
        this.shopRegistrationDoc,
        this.shopPhoto,
        this.openingTime,
        this.closingTime,
        this.closingMessage,
        this.holidayMessage,
        this.shopDescription,
        this.activeStatus,
        this.createdAt,
        this.updatedAt,
        this.shopRating,
        this.itemPrice,
   });

  GasolineData.fromJson(Map<String, dynamic> json) {
    shopId = json['gasoline_id'];
    userId = json['user_id'];
    shopDisplayId = json['gasoline_display_id'];
    shopName = json['gasoline_name'];
    shopAddress = json['gasoline_address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    shopRegistrationNo = json['gasoline_registration_no'];
    shopRegistrationDoc = json['gasoline_registration_doc'];
    shopPhoto = json['gasoline_photo'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    closingMessage = json['closing_message'];
    holidayMessage = json['holiday_message'];
    shopDescription = json['gasoline_description'];
    activeStatus = json['active_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shopRating = json['gasoline_rating'];
    if (json['gasoline_item'] != null) {
      itemPrice = <ItemPrice>[];
      json['gasoline_item'].forEach((v) {
        itemPrice.add(new ItemPrice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gasoline_id'] = this.shopId;
    data['user_id'] = this.userId;
    data['gasoline_display_id'] = this.shopDisplayId;
    data['gasoline_name'] = this.shopName;
    data['gasoline_address'] = this.shopAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['gasoline_registration_no'] = this.shopRegistrationNo;
    data['gasoline_registration_doc'] = this.shopRegistrationDoc;
    data['gasoline_photo'] = this.shopPhoto;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['closing_message'] = this.closingMessage;
    data['holiday_message'] = this.holidayMessage;
    data['gasoline_description'] = this.shopDescription;
    data['active_status'] = this.activeStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['gasoline_rating'] = this.shopRating;
    if (this.itemPrice != null) {
      data['gasoline_item'] = this.itemPrice.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemPrice {
  String name;
  String price;

  ItemPrice({this.name, this.price});

  ItemPrice.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}

