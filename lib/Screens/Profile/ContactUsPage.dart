import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {

  String aboutUsContent = "";
  //List<ContactUsResponseData> dataList =[];
  TextEditingController   myContactEmail = TextEditingController();
  TextEditingController   myMobileNo = TextEditingController();
  TextEditingController  myAddress = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
    //  this.contactUsDetailsApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          "Contact",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color: Colors.black),
        ),
          leading: IconButton(
              icon:new Image.asset('images/back_icon.png'),
              onPressed: () {
                /*     Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return MyMainPage(); // My Main page
                      },
                    ),
                    );*/
              }),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child:Center(
           child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 8, top: 4),
                child: Text(
                  "Contact Email",
                  maxLines: 1,
                  softWrap: true,
                  style: CustomTextStyle.textFormFieldSemiBold
                      .copyWith(fontSize: 14,color: Colors.brown),
                ),
              ),
              getSizedBox(height: 4),
              TextFormField(
                enabled: false,
                controller: myContactEmail,
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                maxLength: 50,
                decoration: InputDecoration(
                  fillColor: Colors.brown,
                  hintText: 'Email not available!',
                  border: OutlineInputBorder(),
                ),
              ),
              getSizedBox(height: 4),

              Text(

                "Mobile No",
                style: CustomTextStyle.textFormFieldSemiBold
                    .copyWith(color: Colors.brown[400], fontSize: 14),overflow: TextOverflow.ellipsis,
              ),
              getSizedBox(height: 4),
              TextFormField(
                enabled: false,
                controller: myMobileNo,
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                maxLength: 50,
                decoration: InputDecoration(
                  fillColor: Colors.brown,
                  hintText: 'Mobile no not available!',
                  border: OutlineInputBorder(),
                ),
              ),
              getSizedBox(height: 4),
              Text(

                "Office Address",
                style: CustomTextStyle.textFormFieldSemiBold
                    .copyWith(color: Colors.brown[400], fontSize: 14),overflow: TextOverflow.ellipsis,
              ),
              getSizedBox(height: 4),
              TextFormField(
                enabled: false,
                controller: myAddress,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                maxLength: 80,
                decoration: InputDecoration(
                  fillColor: Colors.brown,
                  hintText: 'Address not available!',
                  border: OutlineInputBorder(),
                ),
              ),

            ],
          ),
          )


        ),
      ),

    );
  }


  static getSizedBox({double width, double height}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }


  /*Future <void> contactUsDetailsApi() async{

    String url = base_url_api+"?key="+api_Key+"&getType="+getContactUsContent;
    EasyLoading.show(status: 'Please wait...');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      EasyLoading.dismiss();

      Map<String, dynamic> getMyRawJson = jsonDecode(response.body);
      CommonContactUsResponse _commonResponse = CommonContactUsResponse.fromJson(getMyRawJson);
      if (_commonResponse.success) {
        setState(() {
          dataList = List<ContactUsResponseData>.from(getMyRawJson["contactusdata"].map((p) => ContactUsResponseData.fromJson(p)));
          myContactEmail = new TextEditingController(text: dataList[0].contact_emails);
          myMobileNo = new TextEditingController(text: dataList[0].mobile_no_1);
          myAddress = new TextEditingController(text: dataList[0].office_address);
        });

      }
    }
    else {
      //  EasyLoading.dismiss();
      throw Exception('Failed to parse json');
    }

  }*/
}
