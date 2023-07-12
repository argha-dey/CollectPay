

  class CommonPaymentHtmlResponse {
  bool success;
  String message;
  String paymentButton;

  CommonPaymentHtmlResponse({
  this.success,
  this.message,
  this.paymentButton,

  });

  factory CommonPaymentHtmlResponse.fromJson(Map<String, dynamic> parsedJson){

  return CommonPaymentHtmlResponse(
  success: parsedJson['success'],
  message: parsedJson['message'],
    paymentButton: parsedJson['paymentButton'],

  );
  }


}