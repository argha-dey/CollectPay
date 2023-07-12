
import 'package:collectpay/Model/SuperMarketCategoryDetails/SuperMarketCategory.dart';
class Data {
  int superMarketId;
  List<SuperMarketCategory> superMarketCategory;
  int userId;
  String superMarketDisplayId = "";
  String superMarketName;
  String superMarketAddress;
  String latitude;
  String longitude;
  String superMarketRegistrationNo;
  String superMarketRegistrationDoc;
  String superMarketPhoto;
  String openingTime;
  String closingTime;
  String closingMessage;
  String holidayMessage;
  String superMarketDescription;
  String activeStatus;
  String createdAt;
  String updatedAt;
  double superMarketRating;
  Data(
      {this.superMarketId,
        this.superMarketCategory,
        this.userId,
        this.superMarketDisplayId,
        this.superMarketName,
        this.superMarketAddress,
        this.latitude,
        this.longitude,
        this.superMarketRegistrationNo,
        this.superMarketRegistrationDoc,
        this.superMarketPhoto,
        this.openingTime,
        this.closingTime,
        this.closingMessage,
        this.holidayMessage,
        this.superMarketDescription,
        this.activeStatus,
        this.createdAt,
        this.updatedAt,
        this.superMarketRating});

  Data.fromJson(Map<String, dynamic> json) {
    superMarketId = json['super_market_id'];
    if (json['super_market_category'] != null) {
      superMarketCategory = <SuperMarketCategory>[];
      json['super_market_category'].forEach((v) {
        superMarketCategory.add(new SuperMarketCategory.fromJson(v));
      });
    }
    userId = json['user_id'];
    superMarketDisplayId = json['super_market_display_id'];
    superMarketName = json['super_market_name'];
    superMarketAddress = json['super_market_address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    superMarketRegistrationNo = json['super_market_registration_no'];
    superMarketRegistrationDoc = json['super_market_registration_doc'];
    superMarketPhoto = json['super_market_photo'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    closingMessage = json['closing_message'];
    holidayMessage = json['holiday_message'];
    superMarketDescription = json['super_market_description'];
    activeStatus = json['active_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    superMarketRating = json['super_market_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['super_market_id'] = this.superMarketId;
    if (this.superMarketCategory != null) {
      data['super_market_category'] =
          this.superMarketCategory.map((v) => v.toJson()).toList();
    }
    data['user_id'] = this.userId;
    data['super_market_display_id'] = this.superMarketDisplayId;
    data['super_market_name'] = this.superMarketName;
    data['super_market_address'] = this.superMarketAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['super_market_registration_no'] = this.superMarketRegistrationNo;
    data['super_market_registration_doc'] = this.superMarketRegistrationDoc;
    data['super_market_photo'] = this.superMarketPhoto;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['closing_message'] = this.closingMessage;
    data['holiday_message'] = this.holidayMessage;
    data['super_market_description'] = this.superMarketDescription;
    data['active_status'] = this.activeStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['super_market_rating'] = this.superMarketRating;

    return data;
  }
}