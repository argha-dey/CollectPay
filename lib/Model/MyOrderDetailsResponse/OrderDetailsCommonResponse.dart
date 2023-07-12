
class OrderDetailsCommonResponse {
  bool success;
  String message;
  String order_id;
  String order_date;
  String order_address;
  String  order_by;
  String  order_by_mobile_no;
  String  order_status;
  String order_type;
  String total_item_quantity;
  String subtotal;
  String item_name;

  String item_total_price;
  String total_addon_price;
  String service_charge;
  String total_tax;
  String total_payment_charge;
  String order_subtotal;
  String note;
  String invoice_path;

  List<dynamic> data;




  OrderDetailsCommonResponse({
    this.success,
    this.message,
    this.order_id,
    this.order_date,
    this.order_address,
    this.order_by,
    this.order_by_mobile_no,
    this.order_status,
    this.order_type,
    this.total_item_quantity,
    this.subtotal,
    this.item_name,

    this.item_total_price,
    this.total_addon_price,
    this.service_charge,
    this.total_tax,
    this.total_payment_charge,
    this.order_subtotal,
    this.note,
    this.invoice_path,

    this.data,


  });

  factory OrderDetailsCommonResponse.fromJson(Map<String, dynamic> parsedJson){

    return OrderDetailsCommonResponse(
      success: parsedJson['success'],
      message: parsedJson['message'],
      order_id: parsedJson['order_id'],
      order_date: parsedJson['order_date'],
      order_address: parsedJson['order_address'],
      order_by: parsedJson['order_by'],
      order_by_mobile_no: parsedJson['order_by_mobile_no'],
      order_status: parsedJson['order_status'],
      order_type: parsedJson['order_type'],
      total_item_quantity: parsedJson['total_item_quantity'],

      subtotal: parsedJson['subtotal'],
      item_name: parsedJson['item_name'],


      item_total_price: parsedJson['item_total_price'],
      total_addon_price: parsedJson['total_addon_price'],
      service_charge: parsedJson['service_charge'],
      total_tax: parsedJson['total_tax'],
      total_payment_charge: parsedJson['total_payment_charge'],
      order_subtotal: parsedJson['order_subtotal'],
      note: parsedJson['note'],

      invoice_path: parsedJson['invoice_path'],


      data: parsedJson['data'],
    );
  }

}