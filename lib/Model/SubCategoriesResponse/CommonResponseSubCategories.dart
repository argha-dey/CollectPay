
class CommonResponseSubCategories {
  bool success;
  String message;
  String cateogory_id;
  String cateogory_name;
  String cateogory_slug;

  List<dynamic> SubCatData;

  CommonResponseSubCategories({
    this.success,
    this.message,
    this.cateogory_id,
    this.cateogory_name,
    this.cateogory_slug,
    this.SubCatData
  });

  factory CommonResponseSubCategories.fromJson(Map<String, dynamic> parsedJson){

    return CommonResponseSubCategories(
        success: parsedJson['success'],
        message: parsedJson['message'],
        cateogory_id: parsedJson['cateogory_id'],
        cateogory_name:parsedJson['cateogory_name'],
        cateogory_slug:parsedJson['cateogory_slug'],
        SubCatData: parsedJson['SubCatData']
    );
  }

}