

class NotificationResponseData {
  String id;
  String user_id;
  String heading;
  String description;
  String created_on;



  NotificationResponseData({

    this.id,
    this.user_id,
    this.heading,
    this.description,
    this.created_on,

  });

  factory NotificationResponseData.fromJson(Map<String, dynamic> parsedJson){

    return NotificationResponseData(
      id: parsedJson['id'],
      user_id: parsedJson['user_id'],
      heading: parsedJson['heading'],
      description: parsedJson['description'],
      created_on: parsedJson['created_on'],
    );
  }


}