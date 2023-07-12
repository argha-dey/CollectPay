
class CommonProductDetailsResponse {
  bool success;
  String message;
  String cateogory_id;
  String cateogory_name;
  String cateogory_slug;
  String total_cart_quant;
  List<dynamic> productData;


  CommonProductDetailsResponse({
    this.success,
    this.message,
    this.cateogory_id,
    this.cateogory_name,
    this.cateogory_slug,
    this.total_cart_quant,
    this.productData,

  });

  factory CommonProductDetailsResponse.fromJson(Map<String, dynamic> parsedJson){

    return CommonProductDetailsResponse(
        success: parsedJson['success'],
        message: parsedJson['message'],
        cateogory_id: parsedJson['cateogory_id'],
        cateogory_name:parsedJson['cateogory_name'],
        cateogory_slug:parsedJson['cateogory_slug'],
        total_cart_quant:parsedJson['total_cart_quant'],
        productData: parsedJson['productData'],

    );
  }

}