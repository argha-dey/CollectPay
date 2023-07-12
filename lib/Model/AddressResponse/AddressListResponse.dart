class AddressListResponse {
  List<AddressData> data;


  AddressListResponse({this.data});

  AddressListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) {
        data.add(new AddressData.fromJson(v));
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

class AddressData {
  int id;
  int userId;
  String username;
  String longitude;
  String latitude;
  String postcode;
  String address;
  String city;
  String type;
  String createdAt;
  String updatedAt;
  int is_default;


  AddressData(
      {this.id,
        this.userId,
        this.username,
        this.longitude,
        this.latitude,
        this.postcode,
        this.address,
        this.city,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.is_default,
      });

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    username = json['username'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    postcode = json['postcode'];
    address = json['address'];
    city = json['city'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    is_default = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['postcode'] = this.postcode;
    data['address'] = this.address;
    data['city'] = this.city;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_default'] = this.is_default;
    return data;
  }
}

