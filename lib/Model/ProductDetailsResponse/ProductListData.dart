class ProductListData{
  String id;
  String addon_option_id;
  String  main_category_id;
  String sub_category_id;
  String popular_type;
  String name;
  String description;
  String product_pic;
  String discount_offered;
  String sold_stock;
  String active_status;
  String deleted_status;
  String created_on;
  String cart_exist;
  String cart_quant;
  String custom_product_id;
  String market_price;
  String selling_price;
  String total_cart_quant;
  List<dynamic> custom_option;
  List<dynamic> addon_option;

  ProductListData({
    this.id,
    this.addon_option_id,
    this.main_category_id,
    this.sub_category_id,
    this.popular_type,
    this.name,
    this.description,
    this.product_pic,
    this.discount_offered,
    this.sold_stock,
    this.active_status,
    this.deleted_status,
    this.created_on,
    this.custom_product_id,
    this.market_price,
    this.selling_price,
    this.cart_exist,
    this.cart_quant,
    this.total_cart_quant,
    this.custom_option,
    this.addon_option,
  });


  factory ProductListData.fromJson(Map<String, dynamic> parsedJson){
    return ProductListData(
      id:parsedJson['id'],
      addon_option_id:parsedJson['addon_option_id'],
      main_category_id:parsedJson['main_category_id'],
      sub_category_id:parsedJson['sub_category_id'],
      name:parsedJson['name'],
      description:parsedJson['description'],
      product_pic:parsedJson['product_pic'],
      discount_offered:parsedJson['discount_offered'],
      sold_stock:parsedJson['sold_stock'],
      active_status:parsedJson['active_status'],
      custom_product_id:parsedJson['custom_product_id'],
      market_price:parsedJson['market_price'],
      selling_price:parsedJson['selling_price'],
      cart_exist:parsedJson['cart_exist'],
      cart_quant:parsedJson['cart_quant'],
      total_cart_quant:parsedJson['parsedJson'],
      custom_option:parsedJson['custom_option'],
      addon_option:parsedJson['addon_option'],

    );
  }

}