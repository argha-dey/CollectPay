class ContactUsResponseData{
  String id;
  String heading;
  String office_address;
  String mobile_no_1;
  String contact_emails;





  ContactUsResponseData({
    this.id,
    this.heading,
    this.office_address,
    this.mobile_no_1,
    this.contact_emails,
  });


  factory ContactUsResponseData.fromJson(Map<String, dynamic> parsedJson){
    return ContactUsResponseData(
      id:parsedJson['id'],
      heading:parsedJson['heading'],
      office_address:parsedJson['office_address'],
      mobile_no_1:parsedJson['mobile_no_1'],
      contact_emails:parsedJson['contact_emails'],

    );
  }

}