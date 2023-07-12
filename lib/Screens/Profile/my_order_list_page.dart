import 'package:collectpay/Model/MyOrderDetailsResponse/OrderData.dart';
import 'package:collectpay/Screens/Profile/active_order_history_page.dart';
import 'package:collectpay/Screens/Profile/past_order_history_page.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class MyOrderListPage extends StatefulWidget {
  @override
  _MyOrderListPageState createState() => _MyOrderListPageState();
}

class _MyOrderListPageState extends State<MyOrderListPage> {

  @override
  void initState() {

    super.initState();


  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white70,
           /*   bottom: TabBar(

                tabs: [
                  Tab(child: Text('ACTIVE ORDER')),
                  Tab(child: Text('PAST ORDER')),

                ],
              ),*/
              title: Text('MY ORDERS', style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color: Colors.black),),
               leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
              onPressed: () {
                Navigator.of(context).pop();
              }),


            ),
            body: ActiveOrderHistoryPage()/* TabBarView(
              children: [
                ActiveOrderHistoryPage(),
                PastOrderHistoryPage(),

              ],
            )*/,
          ),
        );

  }


  static getSizedBox({double width, double height}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }




}
