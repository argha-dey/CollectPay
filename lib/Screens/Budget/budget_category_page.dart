
import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/BudgetResponse/BudgetListResponse.dart';
import 'package:collectpay/Model/Menu.dart';
import 'package:collectpay/Screens/Budget/budget_transaction_history_page.dart';
import 'package:collectpay/Screens/Budget/create_new_budget_page.dart';
import 'package:collectpay/Screens/Budget/recharge_user_budget_wallet.dart';
import 'package:collectpay/Screens/Home/home_page.dart';
import 'package:collectpay/Screens/Landing/landing_page.dart';
import 'package:collectpay/Screens/SuperMarket/super_market_product_list_page.dart';
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
import 'package:http/http.dart' as http;



class BudgetPage extends StatefulWidget {
  final String menuCategorySlag;
  const BudgetPage({Key key,this.menuCategorySlag}) : super(key: key);

  @override
  _BudgetPageState createState() => new _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage>  {

  final Connectivity _connectivity = Connectivity();

  List<BudgetData> budgetDataList = [];
  String searchText = "";
  TextEditingController _editingController;

  String select;

  String userToken = "";
  SharedPreferences sharedPreferences;
/*  void _incrementCounter(String cartCount) {
    setState(() {
      _cartCountService.incrementMyVariable(cartCount);
    });
  }*/

  @override
  void initState() {
    super.initState();
    setState(() {
      EasyLoading.dismiss();
      userToken = UserPreferences().userCurrentToken;
      this.getBudgetList();
    });
  }


  Future<void> getBudgetList() async {
    EasyLoading.show(status: 'Please wait...');
    var url = UrlConstants.getBudget;
    print('Token : ${userToken}');

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
        BudgetListResponse  budgetListResponse = BudgetListResponse.fromJson(results);
        setState(() {
          budgetDataList = budgetListResponse.data;
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
          "MY Budget".toUpperCase(),
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color: Colors.black),
        ),

      ),
      body: Builder(builder: (context) {

        return Container(

          child: Stack(
            children: <Widget>[


              Column(

                children: <Widget>[

                  Expanded(
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 14, right:20 ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "",
                                  style: CustomTextStyle.textFormFieldSemiBold
                                      .copyWith(color: CustomColors.kNearbyTextLevelColor, fontSize: 16),overflow: TextOverflow.ellipsis,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return BudgetTransactionHistoryPage(); // My Main page
                                      },
                                    ),
                                    );
                                  },
                                  child:
                                  Text(
                                    "TRANSFER HISTORY",
                                    style: CustomTextStyle.textFormFieldSemiBold
                                        .copyWith(color:Colors.black,fontSize: 16),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          budgetDataList.length>0?Container(

                            child: Card(
                              margin: EdgeInsets.only(top: 50, left: 0, right: 0),
                              color: CustomColors.kBgColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero,
                                ),
                              ),

                              child: Column(

                                children: <Widget>[


                                  new Expanded(

                                    child: new Container(
                                      margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 0.0,bottom: 10.0),

                                      child: GridView.count(
                                        crossAxisCount: 2,

                                        children:List.generate(budgetDataList.length, (int _index_position) => Card(
                                          margin: EdgeInsets.all(10),
                                          shape: RoundedRectangleBorder(
                                            side: new BorderSide(color:  Colors.white, width: 0.0),
                                            borderRadius: BorderRadius.circular(8.0),

                                          ),
                                          clipBehavior: Clip.antiAlias,

                                          child: new InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(new MaterialPageRoute(
                                                    builder: (context) => RechargeUserBudgetWalletPage(budgetId: budgetDataList[_index_position].id.toString(),))).then((value) => setState(() {
                                                  getBudgetList();
                                                }));
                                              },

                                              child: new Container(
                                                margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 30.0,bottom: 5.0),
                                                child: Column(
                                                  children: <Widget>[

                                                    Expanded(

                                                      /*child: Image.network(
                  _menuCategoryDetails[_index_position].image,
                  fit: BoxFit.cover,
                ),*/


                                                      child: Container(


                                                        child:Text(
                                                          budgetDataList[_index_position].name.toUpperCase(),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,
                                                          style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                                                              color:Colors.black, fontSize: 16),
                                                        ),

                                                      ),


                                                      flex: 70,
                                                    ),

                                                    Expanded(
                                                      flex: 30,

                                                      child: Container(

                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[

                                                            Text(
                                                              "SRD "+budgetDataList[_index_position].amount.toString(),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,
                                                              style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                                                                  color:Colors.black, fontSize: 18),
                                                            )
                                                          ],
                                                        ),

                                                      ),
                                                    )

                                                  ],

                                                ),

                                              )

                                          ),

                                        ),), // TODO: Length of Array


                                        // Replace

                                      ),
                                    ),
                                  ),

                                ],
                              ),

                            ),
                          ): new  Container(
                              child: Center(child: Text("No Budget Available!",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color:Colors.blue)))
                          ),
                          Positioned(
                            right: 30,
                            bottom: 30,
                            child:FloatingActionButton(
                              onPressed: () {

                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return CreateNewBudgetPage(); // My Main page
                                  },
                                ),
                                ).then((value) => setState(() {
                                  getBudgetList();
                                }));

                              },
                              child: Icon(Icons.add, color: Colors.white, size: 28,),
                              backgroundColor: Colors.blueAccent,
                              tooltip: 'CREATE NEW BUDGET',
                              elevation: 8,
                              splashColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),

                ],
              )

            ],
          ),
        );
      }),

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



List<Card> _buildGridCards(List<BudgetData> _budgetDataList,BuildContext context) {
  int count =  (_budgetDataList == null) ? 0 : _budgetDataList.length;

  List<Card> cards = List.generate(count, (int _index_position) => Card(
    margin: EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      side: new BorderSide(color:  Colors.white, width: 0.0),
      borderRadius: BorderRadius.circular(8.0),

    ),
    clipBehavior: Clip.antiAlias,

    child: new InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => RechargeUserBudgetWalletPage(budgetId: _budgetDataList[_index_position].id.toString(),)));
        },

        child: new Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 30.0,bottom: 5.0),
          child: Column(
            children: <Widget>[

              Expanded(

                /*child: Image.network(
                  _menuCategoryDetails[_index_position].image,
                  fit: BoxFit.cover,
                ),*/


                child: Container(


                  child:Text(
                    _budgetDataList[_index_position].name.toUpperCase(),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                        color:Colors.black, fontSize: 16),
                  ),

                ),


                flex: 70,
              ),

              Expanded(
                flex: 30,

                child: Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Text(
                        "SRD "+_budgetDataList[_index_position].amount.toString(),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                            color:Colors.black, fontSize: 18),
                      )
                    ],
                  ),

                ),
              )

            ],

          ),

        )

    ),

  ),);

  return cards;
}




getSizedBox({double width, double height}) {
  return SizedBox(
    height: height,
    width: width,
  );
}















