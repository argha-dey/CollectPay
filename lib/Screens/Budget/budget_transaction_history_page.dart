import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/BudgetResponse/BudgetTransferDataListResponse.dart';
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


class BudgetTransactionHistoryPage extends StatefulWidget {

  const BudgetTransactionHistoryPage({Key key}) : super(key: key);

  @override
  _BudgetTransactionHistoryPageState createState() => new _BudgetTransactionHistoryPageState();
}

class _BudgetTransactionHistoryPageState extends State<BudgetTransactionHistoryPage>  {


  List<BudgetTransferData> transferHistoryData = [];



  String select;
  String userToken = "";
  String userId = "";
  SharedPreferences sharedPreferences;



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

    var url = UrlConstants.grt_user_wallet;
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
        BudgetTransferDataListResponse   budgetTransferDataListResponse = BudgetTransferDataListResponse.fromJson(results);

        setState(() {
          transferHistoryData = budgetTransferDataListResponse.data;
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
          "BUDGET TRANSFER HISTORY",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color:Colors.black),
        ),
        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),

      body: Builder(builder: (context) {

        return transferHistoryData.length>0?Container(

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
        itemCount: transferHistoryData.length, itemBuilder: (context, index) {
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
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[




                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: <Widget>[
                                Text(
                                  transferHistoryData[index].budget==null?"  Transfer From":"  Transfer To",
                                  style: CustomTextStyle.textFormFieldSemiBold
                                      .copyWith(color:Colors.black,fontSize: 18),
                                ),
                                Text(
                                  "SRD "+transferHistoryData[index].amount+"  ",
                                  style: CustomTextStyle.textFormFieldSemiBold
                                      .copyWith(color:Colors.grey[500],fontSize: 18),
                                ),
                              ],
                            ),

                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 0),
                            child: Text(
                              transferHistoryData[index].budget==null?"Main Wallet":transferHistoryData[index].budget.name,
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
                      transferHistoryData[index].createdAt.substring(0,10)+"  "+ transferHistoryData[index].createdAt.substring(11,16),
                      style: CustomTextStyle.textFormFieldSemiBold
                          .copyWith(color:Colors.grey[500],fontSize: 14),
                    ),
                    Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            transferHistoryData[index].budget==null?"Debit":" Credit",
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(color:Colors.grey[500],fontSize: 16),
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
















