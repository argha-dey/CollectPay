class SuperMarketResponseData{
  int super_market_id;
  int user_id;
  String super_market_name= "";
  String super_market_address= "";
  String latitude= "";
  String longitude= "";
  String super_market_photo= "";
  String opening_time= "";
  String closing_time= "";
  String holiday_message= "";
  String closing_message= "";
  String super_market_description= "";
  String active_status= "";
  double superMarketRating;




  SuperMarketResponseData({

    this.super_market_id,
    this. user_id,
    this. super_market_name,
    this. super_market_address,
    this. latitude,
    this. longitude,
    this. super_market_photo,
    this. opening_time,
    this. closing_time,
    this. holiday_message,
    this. closing_message,
    this. super_market_description,
    this. active_status,
    this. superMarketRating,
  });

  factory SuperMarketResponseData.fromJson(Map<String, dynamic> map){

    return SuperMarketResponseData(

        super_market_id : map["super_market_id"],
        user_id : map["user_id"],
        super_market_name : map["super_market_name"],
        super_market_address : map["super_market_address"],
        latitude : map["latitude"],
        longitude : map["longitude"],
        super_market_photo : map["super_market_photo"],
        opening_time : map["opening_time"],
        active_status : map["active_status"],
        closing_time : map["closing_time"],
        holiday_message : map["holiday_message"],
        super_market_description : map["super_market_description"],
        closing_message : map["closing_message"],
        superMarketRating : map["super_market_rating"],
    );
  }

}