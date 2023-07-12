import 'dart:convert' as convert;
import 'dart:io';
import 'package:collectpay/Model/SuperMarketCategoryDetails/SuperMarketCategory.dart';
import 'package:collectpay/Model/SuperMarketCategoryDetails/SuperMarketCategoryResponseData.dart';

import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:collectpay/Screens/SuperMarket/super_market_product_list_page.dart';
import 'package:collectpay/utils/CustomColors.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';




class SuperMarketCategoryPage extends StatefulWidget {
  final String superMarketId;
  final String superMarketName;
  const SuperMarketCategoryPage({Key key, @required this.superMarketId,this.superMarketName}) : super(key: key);

  @override
  _SuperMarketCategoryPageState createState() => new _SuperMarketCategoryPageState();
}

class _SuperMarketCategoryPageState extends State<SuperMarketCategoryPage>  {

  final Connectivity _connectivity = Connectivity();
  final List<String> numbers = [];



  List<SuperMarketCategory> superMarketCategoryDataList = [];
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
      this.getSuperMarketUnderCategoryList();
    });
  }


  Future<void> getSuperMarketUnderCategoryList() async {
    EasyLoading.show(status: 'Please wait...');
    var url = UrlConstants.superMarketCategory + widget.superMarketId;
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
           SuperMarketCategoryResponseData superMarketData = SuperMarketCategoryResponseData.fromJson(results);
        setState(() {
          superMarketCategoryDataList = superMarketData.data.superMarketCategory;
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

      body: Builder(builder: (context) {

        return Container(

          child: Stack(
            children: <Widget>[
              Container(
                height: 230,
                decoration: BoxDecoration(
                    image: DecorationImage(

                      /*     image: NetworkImage(subCatImage),*/
                      image:AssetImage("images/category_banner_icon.png"),

                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),

              ),
              Container(
                child: Text(
                  widget.superMarketName.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
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
                      Navigator.of(context).pop(true);
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





                                  new Expanded(

                                    child: new Container(
                                      margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 0.0,bottom: 10.0),

                                      child: superMarketCategoryDataList.length>0?GridView.count(
                                          crossAxisCount: 2,

                                          children:_buildGridCards(superMarketCategoryDataList,context,widget.superMarketId) // TODO: Length of Array


                                        // Replace

                                      ): new  Container(
        child: Center(child: Text("No Category Available!",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color:Colors.blue))))
        ,
                                    ),
                                  ),

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
}

addRadioButton(BuildContext superContext, int i, String s) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[


    ],
  );
}



List<Card> _buildGridCards(List<SuperMarketCategory> superMarketCategoryDataList,BuildContext context,String superMarketId) {
  int count =  (superMarketCategoryDataList == null) ? 0 : superMarketCategoryDataList.length;

  List<Card> cards = List.generate(count, (int _index_position) => Card(
    margin: EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      side: new BorderSide(color:  Colors.white, width: 0.0),
      borderRadius: BorderRadius.circular(8.0),

    ),
    clipBehavior: Clip.antiAlias,

    child: new InkWell(
        onTap: () {
          int super_market_category_id = superMarketCategoryDataList[_index_position].superMarketCategoryId;
          int category_id = superMarketCategoryDataList[_index_position].category.categoryId;
          String categoryName = superMarketCategoryDataList[_index_position].category.name;
          print("tapped super_market_category_id =>  $super_market_category_id");
          print("tapped category_id =>  $category_id");
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => SuperMarketProductListPage(superMarketCategoryId: super_market_category_id.toString(),superMarketId:superMarketId,categoryId:category_id.toString(),categoryName:categoryName)));
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

                  decoration: BoxDecoration(
                    image: DecorationImage(
                     /*   image:AssetImage("images/category_icon.png",*/
                              image: NetworkImage(superMarketCategoryDataList[_index_position].category.image,
                        ), fit: BoxFit.cover),

                  ),


                ),



                flex: 70,
              ),
              SizedBox(height:10),
              Expanded(
                flex: 30,

                child: Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      getSizedBox(height: 7),
                      Text(
                        superMarketCategoryDataList[_index_position].category.name,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                            color:Colors.black, fontSize: 12),
                      )
                    ],
                  ),

                ),
              )

            ],

          ),

        )

    ),

  ),
  );

  return cards;
}


getSizedBox({double width, double height}) {
  return SizedBox(
    height: height,
    width: width,
  );
}















