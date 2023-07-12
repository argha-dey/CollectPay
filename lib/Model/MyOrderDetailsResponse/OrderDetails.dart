
class OrderDetails {
  String order_type;
  String order_id;
  String order_paid_price;
  String order_date;
  String item_total;
  String  order_other_charge;
  String order_subtotal;
  String order_status;
  String order_by_name;
  String  order_by_mobile_no;
  String  item_id;
  String  item_total_price;
  String  item_name;
  String item_description;
  String item_image;
  String selling_price;
  String  market_price;
  String  item_quantity;
 String item_addon_name;


  OrderDetails({

    this.order_type,
    this.order_id,
    this.order_paid_price,
    this.order_date,
    this.item_total,
    this.order_other_charge,
    this.order_subtotal,
    this.order_status,
    this.order_by_name,
    this.order_by_mobile_no,
    this.item_id,
    this.item_total_price,
    this.item_name,
    this.item_description,
    this.item_image,
    this.selling_price,
    this.market_price,
    this.item_quantity,
    this.item_addon_name,

  });

  factory OrderDetails.fromJson(Map<String, dynamic> parsedJson){

    return OrderDetails(
      order_type: parsedJson['order_type'],
      order_id: parsedJson['order_id'],
      order_paid_price: parsedJson['order_paid_price'],
      order_date:parsedJson['order_date'],
      item_total:parsedJson['item_total'],
      order_other_charge: parsedJson['order_other_charge'],
      order_subtotal:parsedJson['order_subtotal'],
      order_status:parsedJson['order_status'],
      order_by_name: parsedJson['order_by_name'],
      order_by_mobile_no: parsedJson['order_by_mobile_no'],
      item_id: parsedJson['item_id'],
      item_total_price:parsedJson['item_total_price'],
      item_name:parsedJson['item_name'],
      item_description: parsedJson['item_description'],
      item_image:parsedJson['item_image'],
      selling_price:parsedJson['selling_price'],
      market_price: parsedJson['market_price'],
      item_quantity: parsedJson['item_quantity'],
      item_addon_name: parsedJson['item_addon_name'],

    );
  }


}