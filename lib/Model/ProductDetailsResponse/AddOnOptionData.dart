
class AddOnOptionData {
  String id;
  String caterogy_id;
  String name;
  String price;
  String active_status;
  bool status ;



  AddOnOptionData({
    this.id,
    this.caterogy_id,
    this.name,
    this.price,
    this.active_status,
    this.status,
  });

  factory AddOnOptionData.fromJson(Map<String, dynamic> parsedJson){

    return AddOnOptionData(
      id: parsedJson['id'],
      caterogy_id: parsedJson['caterogy_id'],
      name: parsedJson['name'],
      price:parsedJson['price'],
      active_status:parsedJson['active_status'],
      status: false,
    );
  }

}