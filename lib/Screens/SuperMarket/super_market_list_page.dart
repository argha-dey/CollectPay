
import 'dart:io';

import 'package:collectpay/Model/SuperMarketDetails/SuperMarketResponseData.dart';
import 'package:collectpay/Screens/SuperMarket/super_market_category_page.dart';
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
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../appConstants.dart';


class SuperMarketListPage extends StatefulWidget {
  final String menuCategorySlag;
  const SuperMarketListPage({Key key, @required this.menuCategorySlag}) : super(key: key);

  @override
  _SuperMarketListPageState createState() => new _SuperMarketListPageState();
}

class _SuperMarketListPageState extends State<SuperMarketListPage>  {

  final Connectivity _connectivity = Connectivity();
  final List<String> numbers = [];
  List<SuperMarketResponseData> superMarketResponseDataList = [];
  List<SuperMarketResponseData> superMarketResponseDataListTemp = [];
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
      this.getSuperMarketList();
    });
  }



  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<SuperMarketResponseData> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = superMarketResponseDataList;
      setState(() {
        superMarketResponseDataListTemp = results;
      });
    } else {
      for (int i = 0; i < superMarketResponseDataList.length; i++) {
        if (superMarketResponseDataList[i].super_market_name.toLowerCase()
            .contains(enteredKeyword.toLowerCase())) {
          results.add(superMarketResponseDataList[i]);
        }
      }
      // Refresh the UI
      setState(() {
        superMarketResponseDataListTemp = results;
      });
    }
  }



  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getSuperMarketList() async {
    EasyLoading.show(status: 'Please wait...');
    var url = UrlConstants.superMarket;
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
        Map<String, dynamic> getMyRawJson = jsonDecode(response.body);
        setState(() {
          superMarketResponseDataList =  List<SuperMarketResponseData>.from(getMyRawJson["data"].map((p) => SuperMarketResponseData.fromJson(p)));

          superMarketResponseDataListTemp = superMarketResponseDataList;
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      resizeToAvoidBottomInset: true,
      body: Builder(builder: (context) {

        return Container(

          child: Stack(
            children: <Widget>[
              Container(
                height: 230,
                decoration: BoxDecoration(
                    image: DecorationImage(

                      /*     image: NetworkImage(subCatImage),*/
                      image:AssetImage("images/supermarket_banner_icon.png"),

                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),

              ),
              Container(
                child: Text(
                  "SUPER MARKET",
                  style: CustomTextStyle.textFormFieldBold
                      .copyWith(color: Colors.black, fontSize: 18),
                ),
                margin: EdgeInsets.only(top: 43, left: 55),
              ),
              Container(
                child:
                IconButton(
                    icon:new Image.asset('images/back_icon.png'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                margin: EdgeInsets.only(top: 30, left: 5),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                    flex: 20,
                  ),
                  Expanded(
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(

                            child: Card(
                              margin: EdgeInsets.only(top: 60, left: 0, right: 0),
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
                                  SizedBox(height:30),

                                  RoundedSearchInputField(
                                    controller: _editingController,
                                    hintText: "Search",
                                    onChanged: (value) {
                                      setState(() {
                                        searchText = value;
                                        _runFilter(searchText);
                                      });
                                    },
                                  ),
                                  SizedBox(height:20),
                                  new Container(
                                    margin: const EdgeInsets.only(left: 20.0,bottom:8.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "NEAR BY SUPER MARKET",
                                      style: CustomTextStyle.textFormFieldBold
                                          .copyWith(color: CustomColors.kNearbyTextLevelColor, fontSize: 16),overflow: TextOverflow.ellipsis,
                                    ),),

                                  superMarketResponseDataListTemp.length>0? Flexible(

                                      child:buildListView()

                                  ): new  Container(
                                      margin: const EdgeInsets.only(top:100),
                                      child: Center(child: Text("No SuperMarket Available!",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color:Colors.black)))),

                                ],
                              ),

                            ),
                          ),

                        ],
                      ),

                    ),
                    flex: 80,
                  ),
                ],
              )

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
        itemCount: superMarketResponseDataListTemp.length, itemBuilder: (context, index) {
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
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        image: DecorationImage(

                           /* image:AssetImage("images/super_market_icon.png",*/
                                  image: NetworkImage(superMarketResponseDataListTemp[index].super_market_photo,
                            ), fit: BoxFit.cover)
                    )),

                Expanded(
                  child: new InkWell(
                    onTap: () {
                      int super_market_id =  superMarketResponseDataListTemp[index].super_market_id;
                      String superMarketName = superMarketResponseDataListTemp[index].super_market_name;
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => SuperMarketCategoryPage(superMarketId:super_market_id.toString(),superMarketName: superMarketName,))).then((value) => setState(() {
                        getSuperMarketList();
                      }));
                    },

                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 8, top: 4),
                            child: Text(superMarketResponseDataListTemp[index].super_market_name.toUpperCase()
                              ,
                              maxLines:1,
                              softWrap: true,
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(fontSize: 12,color:Colors.black),
                            ),
                          ),
                          getSizedBox(height: 5),
                          Text(
                            superMarketResponseDataListTemp[index].super_market_description,overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: true,
                            style: CustomTextStyle.textFormFieldRegular
                                .copyWith(color:Colors.black, fontSize: 10),
                          ),
                          getSizedBox(height: 5),

                          Text(
                            superMarketResponseDataList[index].super_market_address,overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(color:Colors.black,fontSize: 11),
                          ),

                          getSizedBox(height: 5),
                          SmoothStarRating(
                            rating: superMarketResponseDataListTemp[index].superMarketRating,
                            isReadOnly:true,
                            color: Colors.yellow,
                            borderColor: Colors.black,
                            size: 12,
                            filledIconData: Icons.star,
                            starCount: 5,
                            spacing: 1.0,

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
















