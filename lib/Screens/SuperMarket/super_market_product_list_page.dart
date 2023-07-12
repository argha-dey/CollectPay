import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/SuperMarketProduct/SuperMarketProductUnderCategoryResponseData.dart';
import 'package:collectpay/Screens/SuperMarket/super_market_category_page.dart';
import 'package:collectpay/main.dart';
import 'package:collectpay/utils/CustomColors.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/UserPreferences.dart';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../appConstants.dart';



class SuperMarketProductListPage extends StatefulWidget {
  final String superMarketCategoryId;
  final String  superMarketId;
  final String categoryId;
  final String categoryName;
  const SuperMarketProductListPage({Key key, this.superMarketCategoryId,this.superMarketId, this.categoryId,this.categoryName}) : super(key: key);

  @override
  _SuperMarketProductListPageState createState() => new _SuperMarketProductListPageState();
}

class _SuperMarketProductListPageState extends State<SuperMarketProductListPage>  {

  final Connectivity _connectivity = Connectivity();
  final List<String> numbers = [];

  List<ProductData> superMarketProductDataList = [];
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
      this.getSuperMarketProductUnderCategoryList();
    });
  }




  Future<void> getSuperMarketProductUnderCategoryList() async {
    EasyLoading.show(status: 'Please wait...');
    var url = UrlConstants.superMarketProduct + widget.categoryId+"&super_market_id="+widget.superMarketId;
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
        SuperMarketProductUnderCategoryResponseData superMarketProductData = SuperMarketProductUnderCategoryResponseData.fromJson(results);
        setState(() {
          superMarketProductDataList = superMarketProductData.data;

        });

        Provider.of<CartCount>(context, listen: false).updateCartCount(superMarketProductData.totalCartItems);
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


// Product Add Api
  Future<void> productAddApiCall(String productId,String quantity,String superMarketId) async {
    EasyLoading.show(status: 'Please wait...');

    Map<String, String> _requestBody = <String, String>{
      'quantity':quantity,
      'product_id': productId,
      'super_market_id': superMarketId,
    };

    var _body = json.encode(_requestBody);
    print("request_json=$_body");

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.productAddRemove;

    Uri myUri = Uri.parse(url);

    print('url : $myUri');
    final http.Response response  = await httpTemp.post(
        myUri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
        body: _body,
        encoding: Encoding.getByName("utf-8")
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> results  = jsonDecode(response.body);
        EasyLoading.dismiss();
        getSuperMarketProductUnderCategoryList();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
    }
  }

// Product Remove Api
  Future<void> productRemoveApiCall(String productId,String quantity,String superMarketId) async {
    EasyLoading.show(status: 'Please wait...');

    Map<String, String> _requestBody = <String, String>{
      'quantity':quantity,
      'product_id': productId,
      'super_market_id': superMarketId,
    };

    var _body = json.encode(_requestBody);
    print("request_json=$_body");

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.productAddRemove;

    Uri myUri = Uri.parse(url);
    print('url : $myUri');
    final http.Response response  = await httpTemp.post(
        myUri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
        body: _body,
        encoding: Encoding.getByName("utf-8")
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> results  = jsonDecode(response.body);
        EasyLoading.dismiss();
        getSuperMarketProductUnderCategoryList();

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

        return Container(

          child: Stack(
            children: <Widget>[
              Container(
                height: 230,
                decoration: BoxDecoration(
                    image: DecorationImage(

                      /*     image: NetworkImage(subCatImage),*/
                      image:AssetImage("images/product_banner_icon.png"),

                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),

              ),
              Container(
                child: Text(
                  widget.categoryName.toUpperCase(),
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
                    child: superMarketProductDataList.length>0?Container(
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



                                  Flexible(

                                    child: buildListView(),
                                  ),

                                ],
                              ),

                            ),
                          ),

                        ],
                      ),
                    ):new  Container(
                        child: Center(child: Text("No Product Available!",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color:Colors.blue)))),
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
        itemCount: superMarketProductDataList.length, itemBuilder: (context, index) {
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

                        /*    image:AssetImage("images/product_icon.png",*/
                                   image: NetworkImage(superMarketProductDataList[index].image,
                            ), fit: BoxFit.cover)
                    )),

                Expanded(
                  child: new InkWell(
                    onTap: () {


                    },

                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 8, top: 4),
                            child: Text(
                              superMarketProductDataList[index].name,
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(fontSize: 15,color:Colors.black),
                            ),
                          ),
                          getSizedBox(height: 10),
                          Text(
                            superMarketProductDataList[index].description,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyle.textFormFieldRegular
                                .copyWith(color:Colors.black, fontSize: 13),
                          ),
                          getSizedBox(height: 5),
                          Text(
                            superMarketProductDataList[index].discount,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyle.textFormFieldRegular
                                .copyWith(color:Colors.green, fontSize: 12),
                          ),
                          getSizedBox(height: 5),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "SRD "+superMarketProductDataList[index].sellingPrice,
                                  style: CustomTextStyle.textFormFieldSemiBold
                                      .copyWith(color:Colors.black,fontSize: 13),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 0.0, bottom: 5.0,left: 10.0,right: 10.0),

                                  child: Container(

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(2)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                                      ],
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        stops: [0.0, 1.0],
                                        colors: [
                                          CustomColors.kButtonGradientColorOne,
                                          CustomColors.kButtonGradientColorTwo,
                                        ],
                                      ),


                                    ),

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[

                                        GestureDetector(

                                          onTap: () {
                                            int _quantity = superMarketProductDataList[index].buyerCartQuantity;
                                            String _productId = superMarketProductDataList[index].productId.toString();
                                            String _superMarketId = superMarketProductDataList[index].superMarketId.toString();
                                            if (_quantity>0) {
                                              _quantity = _quantity - 1;
                                              productRemoveApiCall(_productId, _quantity.toString(), _superMarketId);
                                            }


                                          },


                                          child:Icon(
                                            Icons.remove,
                                            size: 24,
                                            color: Colors.white,
                                          ),

                                        ),


                                        Container(

                                          padding: const EdgeInsets.only(
                                              bottom: 2, right: 12, left: 12),
                                          child: Text(
                                            superMarketProductDataList[index].buyerCartQuantity.toString(),
                                            style: CustomTextStyle.textFormFieldRegular
                                                .copyWith(color:Colors.white),
                                          ),
                                        ),


                                        GestureDetector(
                                          onTap: () {
                                            int _quantity = superMarketProductDataList[index].buyerCartQuantity;
                                            String _productId = superMarketProductDataList[index].productId.toString();
                                            String _superMarketId = superMarketProductDataList[index].superMarketId.toString();
                                            if (_quantity>=0) {
                                              _quantity = _quantity + 1;
                                              productRemoveApiCall(_productId, _quantity.toString(), _superMarketId);
                                            }
                                          },


                                          child:  Icon(
                                            Icons.add,
                                            size: 24,
                                            color: Colors.white,
                                          ),

                                        )
                                        // Add Icon

                                      ],
                                    ),
                                  ),
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
















