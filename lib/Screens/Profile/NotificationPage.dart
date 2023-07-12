import 'package:collectpay/Model/NotificationResponse/NotificationResponseData.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
 List<NotificationResponseData> notificationList = [];
  String userId = "";
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  getCredential();
    setState(() {
    //  userId = UserPreferences().userCurrentId;
    //  this.getUserNotificationApiCall();
    });
  }
/*  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = UserPreferences().userCurrentId;
    });
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          "Notifications",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color: Colors.black),
        ),

        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: notificationList.length>0? ListView.builder(
        itemBuilder: (context, index) {
          return createNotificationListItem(index);
        },
        itemCount:notificationList.length,
      ): new  Container(
    child: Center(child: Text("No Notification Available!",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color:Colors.black)))
    ),
    );
  }


  createNotificationListItem(int index) {
    return Dismissible(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        notificationList[index].heading,
                        style: CustomTextStyle.textFormFieldBlack
                            .copyWith(color: Colors.brown[600], fontSize: 16),
                      ),
                      IconButton(icon: Icon(Icons.close), onPressed: () {

                        setState(() {
                         // removeNotificationApiCall(context, notificationList[index].id);
                        });

                      })
                    ],
                  ),
                  Container(
                    child: Text(
                      "Hi,your "+notificationList[index].description+". Thank you for using. Have a nice day!",
                      textAlign: TextAlign.left,
                      style: CustomTextStyle.textFormFieldMedium
                          .copyWith(color: Colors.grey, fontSize: 14),
                    ),
                  )
                ],
              ),
              flex: 98,
            )
          ],
        ),
      ),
      key: Key("key_1"),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        notificationList.removeAt(index);
      },

    );
  }

/*  static List getDummyList() {
    List list = List.generate(10, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }*/

/*
  Future<void> getUserNotificationApiCall() async{


    String url = base_url_api+"?key="+api_Key+"&getType="+getAllNotificationData+"&user_id="+userId;
    EasyLoading.show(status: 'Please wait...');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      EasyLoading.dismiss();

      Map<String, dynamic> getMyRawJson = jsonDecode(response.body);
      CommonNotificationResponse _commonResponse = CommonNotificationResponse.fromJson(getMyRawJson);
      if (_commonResponse.success) {
        setState(() {
          // Get the JSON data
          notificationList = List<NotificationResponseData>.from(getMyRawJson["notificationdata"].map((p) => NotificationResponseData.fromJson(p)));
        });

      }
    }
    else {
      //  EasyLoading.dismiss();
      throw Exception('Failed to parse json');
    }

  }


  Future<void> removeNotificationApiCall(BuildContext context,String notificationId ) async {

    Map<String, String> requestBody = <String,String>{
      'key': api_Key,
      'postType': 'DeleteNotification',
      'notification_id': notificationId,
    };

    Map<String, String> headers= <String,String>{
      'Content-Type':'multipart/form-data'
      */
/*    'Authorization':'Basic ${base64Encode(utf8.encode('user:password'))}'*//*

    };

    EasyLoading.show(status: 'Please wait...');
    var uri = Uri.parse(base_url_api);
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields.addAll(requestBody);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      //JsonObject  _data = jsonDecode(respStr);

      DeleteNotificationResponse _orderPlaceResponse =  DeleteNotificationResponse.fromJson(jsonDecode(respStr));
      if(_orderPlaceResponse.success) {

        EasyLoading.showSuccess('successfully Delete!');
        setState(() {
          getUserNotificationApiCall();
        });

      }
      else{
        EasyLoading.showError('Failed');
      }
    }
    else {
      EasyLoading.dismiss();
      throw Exception('Failed to parse data');
    }


  }
*/


}

