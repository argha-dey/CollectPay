import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/TransferHistory/TransferHistoryResponse.dart';
import 'package:collectpay/Screens/SuperMarket/super_market_category_page.dart';
import 'package:collectpay/Screens/Wallet/send_money_from_contact_list_page.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/CustomColors.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:collectpay/utils/rounded_search_input_field.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
//import 'package:intl/intl_browser.dart';


class TransactionHistoryPage extends StatefulWidget {

  const TransactionHistoryPage({Key key}) : super(key: key);

  @override
  _TransactionHistoryPageState createState() => new _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage>  {

  final Connectivity _connectivity = Connectivity();
   List<TransferHistoryData> transferHistoryDataTemp = [];
  List<TransferHistoryData> transferHistoryData = [];
String moneySendType = "";

 // var outputDate =  DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(parseDate.toString()));

  String searchText = "";
  TextEditingController _editingController;

  String select;

  String userToken = "";
  String userId = "";
  SharedPreferences sharedPreferences;

/*  void _incrementCounter(String cartCount) {
    setState(() {
      _cartCountService.incrementMyVariable(cartCount);
    });
  }*/

  @override
  void initState() {
    setState(() {
      EasyLoading.dismiss();
      userToken = UserPreferences().userCurrentToken;
      userId = UserPreferences().userCurrentId;
      this.transactionHistoryGetDataApi();
    });
    super.initState();
  }

// profile  Details Api
  Future<void> transactionHistoryGetDataApi() async {
    EasyLoading.show(status: 'Please wait...');

    var url = UrlConstants.transfer;
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
        EasyLoading.dismiss();
        TransferHistoryResponse  transferHistoryResponse = TransferHistoryResponse.fromJson(results);

        setState(() {
          transferHistoryData = transferHistoryResponse.data;
          transferHistoryDataTemp = transferHistoryData;
        });

      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
    }
  }


  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<TransferHistoryData> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = transferHistoryData;
      setState(() {
        transferHistoryDataTemp = results;
      });
    } else {
      for (int i = 0; i < transferHistoryData.length; i++) {
        if (transferHistoryData[i].to.mobile.toLowerCase()
            .contains(enteredKeyword.toLowerCase())) {
          results.add(transferHistoryData[i]);
        }
      }
      // Refresh the UI
      setState(() {
        transferHistoryDataTemp = results;
      });
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
          "TRANSACTION HISTORY",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color:Colors.black),
        ),
        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),

      body: Builder(builder: (context) {

        return transferHistoryDataTemp.length>0?Container(

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
        itemCount: transferHistoryDataTemp.length, itemBuilder: (context, index) {
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
                Container(
                    margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        image: DecorationImage(

                      /*      image:AssetImage("images/ic_user_profile.png",*/
                                  image: NetworkImage(transferHistoryDataTemp[index].from.image,
                            ), fit: BoxFit.cover)
                    )),

                Expanded(
                  child: new InkWell(
                    onTap: () {
/*
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => SuperMarketCategoryPage()));*/

                    },

                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[




                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  transferHistoryDataTemp[index].fromId.toString()==userId?"PAID TO":"RECEIVE FROM",
                                  style: CustomTextStyle.textFormFieldSemiBold
                                      .copyWith(color:Colors.black,fontSize: 18),
                                ),
                                Text(
                                  "SRD "+transferHistoryDataTemp[index].amount+"  ",
                                  style: CustomTextStyle.textFormFieldSemiBold
                                      .copyWith(color:Colors.grey[500],fontSize: 18),
                                ),
                              ],
                            ),

                          Container(
                            padding: EdgeInsets.only(right: 8, top: 8),
                            child: Text(
                             transferHistoryDataTemp[index].to.userId.toString()==userId?transferHistoryDataTemp[index].from.name: transferHistoryDataTemp[index].fromId.toString()==userId?transferHistoryDataTemp[index].to.name:"",
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

      margin: EdgeInsets.only(left: 16, right: 16, top: 6,bottom: 6),
               child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      transferHistoryDataTemp[index].createdAt.substring(0,10)+"  "+ transferHistoryDataTemp[index].createdAt.substring(11,16),
                      style: CustomTextStyle.textFormFieldSemiBold
                          .copyWith(color:Colors.grey[500],fontSize: 14),
                    ),
                    Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Debited from wallet",
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(color:Colors.grey[500],fontSize: 14),
                          ),
                      Container(
                        margin: EdgeInsets.only( left: 6),
                       )
                          /*Container(
                              margin: EdgeInsets.only( left: 6),
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,

                                  image: DecorationImage(

                                      image:AssetImage("images/ic_user_profile.png",
                                        *//*    image: NetworkImage(_productDetailsList[index].product_pic,*//*
                                      ), fit: BoxFit.cover)
                              )),*/
                        ],
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
















