
class CartDetailsCommonResponse {
  bool success;
  String message;
  String total_count;
  String cart_total_price;
  String total_addon_price;
  String service_charge;
  String total_tax;
  String total_payment_charge;
  String order_sub_total;
  String total_delivery_charge;
  List<dynamic> cartdata;

  CartDetailsCommonResponse({
    this.success,
    this.message,
    this.total_count,
    this.cart_total_price,
    this.total_addon_price,
    this.service_charge,
    this.total_tax,
    this.total_payment_charge,
    this.order_sub_total,
    this.total_delivery_charge,
    this.cartdata,


  });

  factory CartDetailsCommonResponse.fromJson(Map<String, dynamic> parsedJson){

    return CartDetailsCommonResponse(
      success: parsedJson['success'],
      message: parsedJson['message'],
      total_count: parsedJson['total_count'],
      cart_total_price:parsedJson['cart_total_price'],
      total_addon_price:parsedJson['total_addon_price'],
      service_charge:parsedJson['service_charge'],
      total_tax:parsedJson['total_tax'],
      total_payment_charge:parsedJson['total_payment_charge'],
      total_delivery_charge: parsedJson['total_delivery_charge'],
      order_sub_total: parsedJson['order_sub_total'],
      cartdata: parsedJson['cartdata'],

    );
  }

}