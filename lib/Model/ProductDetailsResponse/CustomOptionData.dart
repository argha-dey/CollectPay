
class CustomOptionData {
  String id;
  String product_id;
  String name;
  String market_price;
  String selling_price;
  String active_status;
  String index;




  CustomOptionData({
    this.id,
    this.product_id,
    this.name,
    this.market_price,
    this.selling_price,
    this.active_status,
    this.index
  });

  factory CustomOptionData.fromJson(Map<String, dynamic> parsedJson){

    return CustomOptionData(
        index: parsedJson['index'],
        id: parsedJson['id'],
        product_id: parsedJson['product_id'],
        name: parsedJson['name'],
        market_price:parsedJson['market_price'],
        selling_price:parsedJson['selling_price'],
        active_status: parsedJson['active_status']
    );
  }

}