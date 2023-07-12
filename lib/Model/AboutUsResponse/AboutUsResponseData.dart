class CategoriesListResponseData{
  String id;
  String about_us_header;
  String about_us_content;






  CategoriesListResponseData({
    this.id,
    this.about_us_header,
    this.about_us_content,

  });


  factory CategoriesListResponseData.fromJson(Map<String, dynamic> parsedJson){
    return CategoriesListResponseData(
        id:parsedJson['id'],
        about_us_header:parsedJson['about_us_header'],
        about_us_content:parsedJson['about_us_content'],

    );
  }

}
