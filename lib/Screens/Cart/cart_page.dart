
import 'dart:convert';

import 'dart:io';

import 'package:collectpay/Model/AddressResponse/AddressListResponse.dart';
import 'package:collectpay/Model/Cart/CartDetails.dart';
import 'package:collectpay/Screens/Cart/manage_address_list_page.dart';
import 'package:collectpay/Screens/Home/home_page.dart';
import 'package:collectpay/Screens/Landing/landing_page.dart';
import 'package:collectpay/main.dart';
import 'package:collectpay/utils/CustomColors.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import '../../appConstants.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String userToken = "";
  SharedPreferences sharedPreferences;
  List<CartData> cartDataList = [];
  CartDetails cartDetails;
  List<AddressData> addressDataList = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      EasyLoading.dismiss();
      userToken = UserPreferences().userCurrentToken;
      this.getCartProductApiCall();
      this.getAddressApiCall();
    });
  }

  // Add Address  Details Api
  Future<void> getAddressApiCall() async {
    EasyLoading.show(status: 'Please wait...');

    var url = UrlConstants.getAddressList;
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
        AddressListResponse  addressListResponse = AddressListResponse.fromJson(results);
        setState(() {
          addressDataList = addressListResponse.data;
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

  // Cart Details Api
  Future<void> getCartProductApiCall() async {
    EasyLoading.show(status: 'Please wait...');

    var url = UrlConstants.getUserCartDetails;
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
        cartDetails = CartDetails.fromJson(results);
        setState(() {
          cartDataList = cartDetails.cartData;
        });
        Provider.of<CartCount>(context, listen: false).updateCartCount(cartDetails.totalItems);
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

  // Product Add Api(+)
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

    final http.Response response  = await httpTemp.post(
        myUri,
        headers:{'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',} ,
        body: _body,
        encoding: Encoding.getByName("utf-8")
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> results  = jsonDecode(response.body);
        EasyLoading.dismiss();
        getCartProductApiCall();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
    }
  }

// Product Remove Api(-)
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

    final http.Response response  = await httpTemp.post(
        myUri,
        headers:{'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',} ,
        body: _body,
        encoding: Encoding.getByName("utf-8")
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> results  = jsonDecode(response.body);
        EasyLoading.dismiss();
        getCartProductApiCall();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
    }
  }

// Product Delete from cart
  Future<void> productDeleteApiCall(String productId) async {
    EasyLoading.show(status: 'Please wait...');


    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.deleteProductFromCart + productId;
    print('Token : ${userToken}');
    print('url : $url');

    Uri myUri = Uri.parse(url);
    var response = await  httpTemp.delete(myUri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken',
    });

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> results  = jsonDecode(response.body);
        EasyLoading.dismiss();
        getCartProductApiCall();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
    }
  }
  // Place Order
  Future<void> placeOrderAddApiCall(CartDetails cartDetails,AddressData addressData,String paymentMode) async {
    EasyLoading.show(status: 'Please wait...');

    //  var productDetails = jsonEncode(cartDetails.cartData);
    //   print(productDetails);
    //  var addressDetails = jsonEncode(addressData);
    //  print(addressDetails);

    Map<String, dynamic> _requestBody = <String, dynamic>{
      'super_market_id':cartDetails.cartData[0].superMarketId.toString(),
      'delivery_address': addressData,
      'product_details': cartDetails.cartData,
      'total_product':cartDetails.totalItems.toString(),
      'sub_total_amount': cartDetails.subTotalAmount.toString(),
      'tax_amount': cartDetails.taxAmount.toString(),
      'delivery_charge': cartDetails.deliveryCharge.toString(),
      'other_charge': cartDetails.otherCharge.toString(),
      'total_amount': cartDetails.totalAmount.toString(),
      'payment_mode': paymentMode,
    };




    var _body = json.encode(_requestBody);
    print("request_json=$_body");

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.placeOrder;

    Uri myUri = Uri.parse(url);

    final http.Response response  = await httpTemp.post(
        myUri,
        headers:{'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',} ,
        body: _body,
        encoding: Encoding.getByName("utf-8")
    );
    try {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Map<String, dynamic> results  = jsonDecode(response.body);
        EasyLoading.showSuccess('Order Place Successfully');
        getCartProductApiCall();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
      print("exception ="+e.toString());
    }
  }

  Future<bool> _willPopCallback() async {
    getAddressApiCall();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    //  final Controller c = Get.put(Controller());
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: new Scaffold(
            backgroundColor: Color(0xffE5E5E5),
            appBar: new AppBar(
              backgroundColor: Colors.white70,
              title: Text(
                "MY CART".toUpperCase(),
                style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color: Colors.black),
              ),
            ),

            body: cartDataList.length>0? new  Column(
                children: <Widget>[

                  Expanded(
// Cart item List
                      child: buildListView()
                  ),




                  SingleChildScrollView(

                      child: Container(
                          margin: EdgeInsets.only(left: 16, right: 16, top: 0,bottom: 0),



                          child:Column(

                              mainAxisAlignment: MainAxisAlignment.end,

                              children: <Widget>[

                                SizedBox(
                                    height: 10
                                ),
                                Row(

                                  children: <Widget>[
                                    Expanded(

                                      child: Text("Cart Amount",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.left),
                                    ),
                                    Expanded(

                                      child:Text("SRD "+cartDetails.subTotalAmount.toString(),style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                    height: 10
                                ),

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text("Tax Amount",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.left),
                                    ),
                                    Expanded(

                                      child:Text("SRD "+cartDetails.taxAmount.toString(),style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),

                                SizedBox(   //Use of SizedBox
                                  height: 6,
                                ),

                                Row(children: <Widget>[
                                  Expanded(
                                    child: new Container(

                                        child: Divider(
                                          color: Colors.brown,
                                          height: 0,
                                        )),
                                  ),

                                  Expanded(
                                    child: new Container(

                                        child: Divider(
                                          color: Colors.brown,
                                          height: 0,
                                        )),
                                  ),
                                ]),

                                SizedBox(   //Use of SizedBox
                                  height: 6,
                                ),

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text("Total Amount",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.left),
                                    ),
                                    Expanded(

                                      child:Text("SRD "+cartDetails.totalAmount.toString(),style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),

                                SizedBox(   //Use of SizedBox
                                  height: 15,
                                ),


                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),

                                  child: SquareButtonLinearGradient(
                                    buttonText: "Place Order (SRD ${cartDetails.totalAmount.toString()})",
                                    press: () {

                                      if (addressDataList.length>0) {
                                        AddressData addressData;
                                        addressDataList.forEach( (item) {
                                          if (item.is_default==1){
                                            addressData = item;
                                          }
                                        });
                                        if (addressData.is_default==1) {
                                          placeOrderAddApiCall(cartDetails,addressData,"1");
                                        }else{
                                          EasyLoading.showError("Kindly Set  Any Address!");
                                        }

                                      } else{
                                        EasyLoading.showError("Kindly Add Any Address!");
                                      }

                                    },
                                    width: double.infinity,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

                                  child: SquareButtonLinearGradient(
                                    buttonText: "SET MY ADDRESS".toUpperCase(),
                                    press: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ManageAddressListPage();
                                          },
                                        ),
                                      ).then((value) =>   setState(() {
                                        getAddressApiCall();
                                      }));
                                    },
                                    width: double.infinity,
                                  ),
                                )
                              ])

                      )
                  )


                ]
            ): new  Container(
                child: Center(child: Text("No Cart Data Available!",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color:Colors.blue)))
            )

        )
    );
  }


  ListView buildListView() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: cartDataList.length, itemBuilder: (context, index) {
      return Stack(
        children: <Widget>[

          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      image: DecorationImage(
                            image: NetworkImage(
                              cartDataList[index].product.image,
                          ),
                        /*  image:AssetImage("images/onboarding_one.png"),*/
                          fit: BoxFit.cover)
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 8, top: 4),
                          child: Text(
                            cartDataList[index].product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(fontSize: 15,color: Colors.black),
                          ),
                        ),
                        getSizedBox(height: 6),
                        Text(
                          cartDataList[index].product.description,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.textFormFieldRegular
                              .copyWith(color: Colors.black, fontSize: 12),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "SRD "+  cartDataList[index].product.sellingPrice,
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(color: Colors.black, fontSize: 13),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(2)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26, offset: Offset(0, 2), blurRadius: 5.0)
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
                                          int _quantity =  cartDataList[index].product.cartQuantity;
                                          String _productId = cartDataList[index].product.productId.toString();
                                          String _superMarketId =  cartDataList[index].product.superMarketId.toString();
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
                                          cartDataList[index].product.cartQuantity.toString(),
                                          style:
                                          CustomTextStyle.textFormFieldSemiBold.copyWith(color:Colors.white),
                                        ) ,
                                      ),


                                      GestureDetector(
                                        onTap: () {
                                          /*     _customOptionData = List<CustomOptionData>.from(cartDataList[index].custom_option .map((u) => CustomOptionData.fromJson(u)));
                                        _addOnOptionData = List<AddOnOptionData>.from(cartDataList[index].addon_option.map((f) => AddOnOptionData.fromJson(f)));
                                        if(_customOptionData.length==1 && _addOnOptionData.length==0) {
                                          userProductItemAddDeleteInCart(context, cartDataList[index], "plus");
                                        }
                                        else {
                                          confirmationPopupForAddSameProduct(context,index);
                                        }*/


                                          int _quantity =  cartDataList[index].product.cartQuantity;
                                          String _productId = cartDataList[index].product.productId.toString();
                                          String _superMarketId =  cartDataList[index].product.superMarketId.toString();
                                          if (_quantity>=0) {
                                            _quantity = _quantity + 1;
                                            productAddApiCall(_productId, _quantity.toString(), _superMarketId);
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
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex: 100,
                )
              ],
            ),
          ),

          Align(
            alignment: Alignment.topRight,
            child:InkWell(
              onTap: () {

                String _productId = cartDataList[index].product.productId.toString();
                String _superMarketId =  cartDataList[index].product.superMarketId.toString();
                // send quantity  = "0" for delete
                productRemoveApiCall(_productId, "0", _superMarketId);

              }, // Handle your callback
              child: Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10, top: 8),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,

                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.red),


              ),
            ),



          ),

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


