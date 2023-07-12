import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/rounded_input_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddBankDetailsPage extends StatefulWidget {
  @override
  _AddBankDetailsPageState createState() => _AddBankDetailsPageState();
}

class _AddBankDetailsPageState extends State<AddBankDetailsPage> {

  String aboutUsContent = "";

 // TextEditingController   myContactEmail = TextEditingController();
 // TextEditingController   myMobileNo = TextEditingController();
 // TextEditingController  myAddress = TextEditingController();

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: new AppBar(
        title: Text("Add Bank Details".toUpperCase(),style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black)),
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
              getSizedBox(height: 4),
              Container(
              margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "Holder Name",
                  maxLines: 1,
                  softWrap: true,
                  style: CustomTextStyle.textFormFieldSemiBold
                      .copyWith(fontSize: 14,color: Colors.black),
                ),
              ),
              getSizedBox(height: 4),
              RoundedInputField(
                icon: null,
                hintText: "",
                onChanged: (value) {
                 // userName = value;
                },
              ),

              getSizedBox(height: 4),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "Bank Name",
                  maxLines: 1,
                  softWrap: true,
                  style: CustomTextStyle.textFormFieldSemiBold
                      .copyWith(fontSize: 14,color: Colors.black),
                ),
              ),
              getSizedBox(height: 4),
              RoundedInputField(
                icon: null,
                hintText: "",
                onChanged: (value) {
                  // userName = value;
                },
              ),

              getSizedBox(height: 4),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "Branch Name",
                  maxLines: 1,
                  softWrap: true,
                  style: CustomTextStyle.textFormFieldSemiBold
                      .copyWith(fontSize: 14,color: Colors.black),
                ),
              ),
              getSizedBox(height: 4),
              RoundedInputField(
                icon: null,
                hintText: "",
                onChanged: (value) {
                  // userName = value;
                },
              ),


              getSizedBox(height: 4),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "Account No.",
                  maxLines: 1,
                  softWrap: true,
                  style: CustomTextStyle.textFormFieldSemiBold
                      .copyWith(fontSize: 14,color: Colors.black),
                ),
              ),
              getSizedBox(height: 4),
              RoundedInputField(
                icon: null,
                hintText: "",
                onChanged: (value) {
                  // userName = value;
                },
              ),

              getSizedBox(height: 4),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "Confirm Accoount No.",
                  maxLines: 1,
                  softWrap: true,
                  style: CustomTextStyle.textFormFieldSemiBold
                      .copyWith(fontSize: 14,color: Colors.black),
                ),
              ),
              getSizedBox(height: 4),
              RoundedInputField(
                icon: null,
                hintText: "",
                onChanged: (value) {
                  // userName = value;
                },
              ),

              getSizedBox(height: 4),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "IFSC Code",
                  maxLines: 1,
                  softWrap: true,
                  style: CustomTextStyle.textFormFieldSemiBold
                      .copyWith(fontSize: 14,color: Colors.black),
                ),
              ),
              getSizedBox(height: 4),
              RoundedInputField(
                icon: null,
                hintText: "",
                onChanged: (value) {
                  // userName = value;
                },
              ),

              getSizedBox(height: 4),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "Bank Location (optional)",
                  maxLines: 1,
                  softWrap: true,
                  style: CustomTextStyle.textFormFieldSemiBold
                      .copyWith(fontSize: 14,color: Colors.black),
                ),
              ),
              getSizedBox(height: 4),
              RoundedInputField(
                icon: null,
                hintText: "",
                onChanged: (value) {
                  // userName = value;
                },
              ),
              getSizedBox(height: 10),
              Container(
                height: 70,
                child: SquareButtonLinearGradient(
                  buttonText: "Save Details".toUpperCase(),
    press: () {
                  /*  Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => AddBankDetailsPage()
                    )
                    );*/
                  },
                  width: size.width * 9,
                ),
              )
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
