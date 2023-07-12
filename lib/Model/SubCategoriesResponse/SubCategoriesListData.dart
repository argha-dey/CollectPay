class SubCategoriesListData{
  String id;
  String parent_id;
  String name;
  String description;
  String image;
  String cat_slug;
  String active_status;
  String deleted_status;
  String created_on;

  SubCategoriesListData({
    this.id,
    this.parent_id,
    this.name,
    this.description,
    this.image,
    this.cat_slug,
    this.active_status,
    this.deleted_status,
    this.created_on,
  });


  factory SubCategoriesListData.fromJson(Map<String, dynamic> parsedJson){
    return SubCategoriesListData(
        id:parsedJson['id'],
        parent_id:parsedJson['parent_id'],
        name:parsedJson['name'],
        description:parsedJson['description'],
        image:parsedJson['image'],
        cat_slug:parsedJson['cat_slug'],
        active_status:parsedJson['active_status'],
        deleted_status:parsedJson['deleted_status'],
        created_on:parsedJson['created_on']
    );
  }

}