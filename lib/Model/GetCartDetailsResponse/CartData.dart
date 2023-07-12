
class CartData {
  String  cart_id;
  String item_id;
  String item_name;
  String item_description;
  String item_image;
  String item_price;
  String item_addon_name ;
  String item_quantity;
  String item_total_price;
  String item_addon_id;
  String product_customized_options_name;
  String product_customized_options_id;

  List<dynamic> custom_option;
  List<dynamic> addon_option;



  CartData({
    this.cart_id,
    this.item_id,
    this.item_name,
    this.item_description,
    this.item_image,
    this.item_price,
    this.item_addon_name,
    this.item_quantity,
    this.item_total_price,
    this.item_addon_id,
    this.product_customized_options_id,
    this.product_customized_options_name,
    this.custom_option,
    this.addon_option,
  });

  factory CartData.fromJson(Map<String, dynamic> parsedJson){

    return CartData(
      cart_id: parsedJson['cart_id'],
      item_id: parsedJson['item_id'],
      item_name: parsedJson['item_name'],
      item_description: parsedJson['item_description'],
      item_image:parsedJson['item_image'],
      item_price:parsedJson['item_price'],
      item_addon_name: parsedJson['item_addon_name'],
      item_quantity:parsedJson['item_quantity'],
      item_total_price:parsedJson['item_total_price'],
      item_addon_id: parsedJson['item_addon_id'],
      product_customized_options_id:parsedJson['product_customized_options_id'],
      product_customized_options_name:parsedJson['product_customized_options_name'],
      custom_option:parsedJson['custom_option'],
      addon_option:parsedJson['addon_option'],
    );
  }

}