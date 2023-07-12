import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/ContactListResponse/ContactListResponse.dart';
import 'package:collectpay/Screens/SuperMarket/super_market_category_page.dart';
import 'package:collectpay/Screens/Wallet/send_money_any_person.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/CustomColors.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:collectpay/utils/rounded_search_input_field.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
// Import package
import 'package:contacts_service/contacts_service.dart';

class SendMoneyFromContactListPage extends StatefulWidget {

  const SendMoneyFromContactListPage({Key key}) : super(key: key);

  @override
  _SendMoneyFromContactListPageState createState() => new _SendMoneyFromContactListPageState();
}

class _SendMoneyFromContactListPageState extends State<SendMoneyFromContactListPage>  {

  final Connectivity _connectivity = Connectivity();
  final List<String> numbers = [];
  List<UserContactData> userContactList = [];

  String searchText = "";
  TextEditingController _editingController;

  String select;
  String userToken = "";
  SharedPreferences sharedPreferences;


  @override
  void initState() {
    userToken = UserPreferences().userCurrentToken;
    _askPermissions();
    super.initState();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      printContactsNumber();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
      SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> printContactsNumber() async {
    Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
    List<Contact> contactsList = contacts.toList();
    List<String> contactsNumber = [];

    for (int i = 0; i < contactsList.length; i++) {
      contactsNumber.add((contactsList[i].phones.first.value.trim().toString()).replaceAll(' ', ''));
    }

    getCollectPayUserDetailsApiCall(contactsNumber);

  }

  // get collect pay user details
  Future<void> getCollectPayUserDetailsApiCall(List<String> contactsNumber) async {
    EasyLoading.show(status: 'Please wait...');

    Map<String, dynamic> _requestBody = <String, dynamic>{
      'phone':contactsNumber,

    };

    var _body = json.encode(_requestBody);
    print("request_json=$_body");

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.getCollectPayUserList;

    Uri myUri = Uri.parse(url);

    final http.Response response  = await httpTemp.post(
        myUri,
        headers:{'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',} ,
        body: _body,
        encoding: Encoding.getByName("utf-8")
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> results  = jsonDecode(response.body);
        ContactListResponse  contactListResponse = ContactListResponse.fromJson(results);
        setState(() {
          userContactList = contactListResponse.data;
        });
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
    }
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          "SELECT CONTACT",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color:Colors.black),
        ),
        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),

      body: Builder(builder: (context) {

        return userContactList.length>0?Container(

          child: Stack(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(

                      child: Column(

                        children: <Widget>[
                          SizedBox(height:25),

                          RoundedSearchInputField(
                            controller: _editingController,
                            hintText: "Enter a mobile number",
                            onChanged: (value) {
                              setState(() {
                                searchText = value;

                              });
                            },
                          ),
                          SizedBox(height:10),
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            child: Row(

                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,

                                        image: DecorationImage(

                                            image:AssetImage("images/dialer_icon.png",
                                              /*    image: NetworkImage(_productDetailsList[index].product_pic,*/
                                            ), fit: BoxFit.cover)
                                    )
                                ),
                                Text(
                                  "New Mobile Number",
                                  style: CustomTextStyle.textFormFieldRegular
                                      .copyWith(color:Colors.black,fontSize: 18),
                                ),
                              ],
                            ),
                          ),

                          Flexible(

                            child: buildListView(),
                          ),
                          SizedBox(height:10),
                        ],
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ): new  Container(
        child: Center(child: Text("No Contact Available!",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color:Colors.blue)))
        );
      }),

    );
  }




// Product List
  ListView buildListView() {
    return ListView.builder(

        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: userContactList.length, itemBuilder: (context, index) {
      return Stack(

        children: <Widget>[

          Container(

            margin: EdgeInsets.only(left: 16, right: 16, top: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        image: DecorationImage(

                          /*  image:AssetImage("images/ic_user_profile.png",*/
                                  image: NetworkImage(userContactList[index].image,
                            ), fit: BoxFit.cover)
                    )),

                Expanded(
                  child: new InkWell(
                    onTap: () {

                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => SendMoneyAnyPersonPage(userContactData:userContactList[index])
                      )
                      );

                    },

                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 8, top: 4),
                            child: Text(
                              userContactList[index].name.toUpperCase(),
                              maxLines: 2,
                              softWrap: true,
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(fontSize: 14,color:Colors.black),
                            ),
                          ),
                          getSizedBox(height: 15),
                          Text(
                            userContactList[index].mobile.toUpperCase(),
                            style: CustomTextStyle.textFormFieldRegular
                                .copyWith(color:Colors.black, fontSize: 14),
                          ),


                        ],
                      ),
                    ),

                  ),
                )
              ],
            ),
          )

        ],
      );
    });
  }


  static getSizedBox({double width, double height}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }



}













addRadioButton(BuildContext superContext, int i, String s) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[


    ],
  );
}
















