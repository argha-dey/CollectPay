
class OrderData {
  String id;
  String user_id;
  String invoice_id;
  String order_date;
  String  order_type;
  String order_expected_time;
  String  price;
  String pay_status;
  String feedback;
  String order_status;
  String  trans_id;
  String  received_date;
  String  item_total_price;
  String   order_delivery_charge;
  String order_other_charge;
  String order_subtotal;
  String comment_on_cancel;
  String  deleted_status;
  String   active_status;
  String created_on;
  String  last_modified_on;
  String  order_items;
  String item_quantity;
  String item_ids;
  String  order_invoice;
  String item_price;
  String item_addon_name;

  OrderData({
    this.id,
    this.user_id,
    this.invoice_id,
    this.order_date,
    this.order_type,
    this.order_expected_time,
    this.price,
    this.pay_status,
    this.feedback,
    this.order_status,
    this.trans_id,
    this.received_date,
    this.item_total_price,
    this.order_delivery_charge,
    this.order_other_charge,
    this.order_subtotal,
    this.comment_on_cancel,
    this.deleted_status,
    this. active_status,
    this. created_on,
    this.last_modified_on,
    this.order_items,
    this.item_quantity,
    this.item_ids,
    this.order_invoice,
    this.item_price,
    this.item_addon_name,
  });

  factory OrderData.fromJson(Map<String, dynamic> parsedJson){

    return OrderData(
      id: parsedJson['id'],
      user_id: parsedJson['user_id'],
      invoice_id: parsedJson['invoice_id'],
      order_date:parsedJson['order_date'],
      order_type:parsedJson['order_type'],
      order_expected_time: parsedJson['order_expected_time'],
      price:parsedJson['price'],
      pay_status:parsedJson['pay_status'],


      feedback: parsedJson['feedback'],
      order_status: parsedJson['order_status'],
      trans_id: parsedJson['trans_id'],
      received_date:parsedJson['received_date'],
      item_total_price:parsedJson['item_total_price'],
      order_delivery_charge: parsedJson['order_delivery_charge'],
      order_other_charge:parsedJson['order_other_charge'],
      order_subtotal:parsedJson['order_subtotal'],


      comment_on_cancel: parsedJson['comment_on_cancel'],
      deleted_status: parsedJson['deleted_status'],
      active_status: parsedJson['active_status'],
      created_on:parsedJson['created_on'],
      order_items:parsedJson['order_items'],
      item_quantity: parsedJson['item_quantity'],
      item_ids:parsedJson['item_ids'],
      order_invoice:parsedJson['order_invoice'],
      item_price:parsedJson['item_price'],
      item_addon_name:parsedJson['item_addon_name'],
    );
  }

}