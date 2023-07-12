import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/OrderPlaceResponse/OrderPlaceResponse.dart';
import 'package:collectpay/Screens/Profile/my_order_details_page.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/CustomColors.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;


class PastOrderHistoryPage extends StatefulWidget {

  const PastOrderHistoryPage({Key key}) : super(key: key);

  @override
  _PastOrderHistoryPageState createState() => new _PastOrderHistoryPageState();
}

class _PastOrderHistoryPageState extends State<PastOrderHistoryPage>  {

  final Connectivity _connectivity = Connectivity();

  TextEditingController _editingController;

  String userToken = "";
  SharedPreferences sharedPreferences;
  List<PlaceOrderData> orderData = [];


  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    userToken = UserPreferences().userCurrentToken;
    this.getActivePlaceOrderDetailsApiCall();

  }


  // Add Address  Details Api
  Future<void> getActivePlaceOrderDetailsApiCall() async {
    EasyLoading.show(status: 'Please wait...');

    var url = UrlConstants.placeOrder;
    print('Token : ${userToken}');
    print('url : $url');

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    Uri myUri = Uri.parse(url);
    var response = await  httpTemp.get(myUri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken',
    });
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> results  = jsonDecode(response.body);
        OrderPlaceResponse  orderPlaceResponse = OrderPlaceResponse.fromJson(results);
        setState(() {
          //   orderData = orderPlaceResponse.data;
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



      body: Builder(builder: (context) {

        return orderData.length>0?  Container(

          child: Stack(
            children: <Widget>[

              Container(
                child: Stack(
                  children: <Widget>[
                    Container(

                      child: Column(

                        children: <Widget>[
                          SizedBox(height:15),






                          Flexible(
                              child: buildListView()
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
            child: Center(child: Text("No Data Available!",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color:Colors.blue)))
        );
      }),



    );
  }




// Product List
  ListView buildListView() {
    return ListView.builder(

        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: orderData.length, itemBuilder: (context, index) {
      return Stack(

        children: <Widget>[

          Container(

              margin: EdgeInsets.only(left: 16, right: 16, top: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child:Column(
                children: [
                  Row(
                    children: <Widget>[


                      Expanded(
                        child: new InkWell(
                          onTap: () {
/*
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => SuperMarketCategoryPage()));*/

                          },

                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[




                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "ORDER ID : "+orderData[index].orderId.toString(),
                                      style: CustomTextStyle.textFormFieldSemiBold
                                          .copyWith(color:Colors.black,fontSize: 18),
                                    ),

                                  ],
                                ),

                                Container(
                                  padding: EdgeInsets.only(right: 20, top: 8),
                                  child: Text(
                                    orderData[index].totalProduct.toString()+"items in Transit",
                                    maxLines: 2,
                                    softWrap: true,
                                    style: CustomTextStyle.textFormFieldSemiBold
                                        .copyWith(fontSize: 14,color:Colors.grey[500]),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 20, top: 8),
                                  child: Text(
                                    "Order Date "+orderData[index].createdAt,
                                    maxLines: 2,
                                    softWrap: true,
                                    style: CustomTextStyle.textFormFieldSemiBold
                                        .copyWith(fontSize: 14,color:Colors.grey[500]),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ),
                      ),

                    ],
                  ),
                  Container(

                    margin: EdgeInsets.only(left: 10, right: 16, top: 6,bottom: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "SRD "+orderData[index].totalAmount,
                          style: CustomTextStyle.textFormFieldSemiBold
                              .copyWith(color:Colors.black,fontSize: 16),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => MyOrderDetailsPage()));

                          },
                          child: Container(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Order Details".toUpperCase(),
                                  style: CustomTextStyle.textFormFieldBold
                                      .copyWith(color:Colors.blue,fontSize: 16),
                                ),
                                Container(
                                    margin: EdgeInsets.only( left: 6),
                                    width: 28,
                                    height: 28,

                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,

                                        image: DecorationImage(

                                            image:AssetImage("images/right_new_arrow_icon.png",
                                              /*    image: NetworkImage(_productDetailsList[index].product_pic,*/
                                            ), fit: BoxFit.cover)
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
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
















