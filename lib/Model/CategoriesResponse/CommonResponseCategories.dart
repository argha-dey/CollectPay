

class CommonResponseCategories {
  bool success;
  String message;
  String total_cart_quant;
  List<dynamic> categoriesResponseData;

  CommonResponseCategories({this.success,this.message,this.total_cart_quant,this.categoriesResponseData});

  factory CommonResponseCategories.fromJson(Map<String, dynamic> parsedJson){

    return CommonResponseCategories(
        success: parsedJson['success'],
        message: parsedJson['message'],
        total_cart_quant:parsedJson['total_cart_quant'],
        categoriesResponseData: parsedJson['data']
    );
  }

}