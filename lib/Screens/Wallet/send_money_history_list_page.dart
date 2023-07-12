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
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;


class SendMoneyHistoryListPage extends StatefulWidget {

  const SendMoneyHistoryListPage({Key key}) : super(key: key);

  @override
  _SendMoneyHistoryListPageState createState() => new _SendMoneyHistoryListPageState();
}

class _SendMoneyHistoryListPageState extends State<SendMoneyHistoryListPage>  {

  final Connectivity _connectivity = Connectivity();
  final List<String> numbers = [];


  String searchText = "";
  TextEditingController _editingController;

  String select;

  String userToken = "";
  String userId = "";
  SharedPreferences sharedPreferences;
  List<TransferHistoryData> transferHistoryDataTemp = [];
  List<TransferHistoryData> transferHistoryData = [];
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

// profile  Details Api
  Future<void> transactionHistoryGetDataApi() async {
    EasyLoading.show(status: 'Please wait...');

    var url = UrlConstants.baseUrl+'/user/'+userId+'/transfer';
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
          "SEND MONEY",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color:Colors.black),
        ),
        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),

      body: Builder(builder: (context) {

        return Container(

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
                                _runFilter(searchText);
                              });
                            },
                          ),
                          SizedBox(height:15),




                          transferHistoryDataTemp.length>0?Flexible(

                            child: buildListView(),
                          ):new  Container(
                              margin: EdgeInsets.only(top: 200),
                              child: Center(child: Text("No Data Available!",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color:Colors.blue)))
                          ),


                          SizedBox(height:10),
                        ],
                      ),
                    ),

                  ],
                ),
              ),

              Positioned(
                right: 30,
                bottom: 30,
                child:FloatingActionButton(
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SendMoneyFromContactListPage(); // My Main page
                      },
                    ),
                    );

                  },
                  child: Icon(Icons.add, color: Colors.white, size: 28,),
                  backgroundColor: Colors.blueAccent,
                  tooltip: 'ADD CONTACT',
                  elevation: 8,
                  splashColor: Colors.grey,
                ),
              ),
            ],
          ),
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
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        image: DecorationImage(

                           /* image:AssetImage("images/ic_user_profile.png",*/
                                  image: NetworkImage( transferHistoryDataTemp[index].to.image,
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
                          Container(
                            padding: EdgeInsets.only(right: 8, top: 0),
                            child: Text(
                              transferHistoryDataTemp[index].to.name,
                              maxLines: 1,
                              softWrap: true,
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(fontSize: 14,color:Colors.black),
                            ),
                          ),
                          getSizedBox(height: 8),
                          Text(
                            "SRD "+ transferHistoryDataTemp[index].amount+" Send Instantly",
                            maxLines: 2,
                            softWrap: true,
                            style: CustomTextStyle.textFormFieldRegular
                                .copyWith(color:Colors.black, fontSize: 12),
                          ),
                          getSizedBox(height: 5),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  transferHistoryDataTemp[index].createdAt.substring(0,10)+"  "+ transferHistoryDataTemp[index].createdAt.substring(11,16),
                                  style: CustomTextStyle.textFormFieldRegular
                                      .copyWith(color:Colors.black,fontSize: 10),
                                ),


                              ],
                            ),
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
















