import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/AddressResponse/AddressListResponse.dart';
import 'package:collectpay/Screens/Cart/add_new_address_from_map.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import '../../appConstants.dart';
import '../../utils/UserPreferences.dart';

class ManageAddressListPage extends StatefulWidget {

  const ManageAddressListPage({Key key}) : super(key: key);

  @override
  _ManageAddressListPageState createState() => new _ManageAddressListPageState();
}

class _ManageAddressListPageState extends State<ManageAddressListPage>  {

  final Connectivity _connectivity = Connectivity();

   List<AddressData> addressDataList = [];

  String searchText = "";
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
    userToken = UserPreferences().userCurrentToken;
    this.getAddressApiCall();
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

  // Delete Address
  Future<void> deleteAddressApiCall(String addressId) async {
    EasyLoading.show(status: 'Please wait...');

    var url = UrlConstants.deleteAddress + addressId;
    print('Token : ${userToken}');
    print('url : $url');

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

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
        getAddressApiCall();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
    }
  }

  // Add Address From Map  Api
  Future<void> editAddressApiCall(AddressData addressData) async {
    EasyLoading.show(status: 'Please wait...');

    Map<String, String> _requestBody = <String, String>{
      'username':addressData.username,
      'longitude': addressData.longitude.toString(),
      'latitude':  addressData.latitude.toString(),
      'postcode':addressData.postcode,
      'address': addressData.address,
      'city': addressData.city,
      'type': addressData.type,
      'is_default':'1'
    };

    var _body = json.encode(_requestBody);
    print("request_json=$_body");

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.getAddressList+"/"+addressData.id.toString();

    Uri myUri = Uri.parse(url);

    final http.Response response  = await httpTemp.put(
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
        EasyLoading.dismiss();
        Map<String, dynamic> results  = jsonDecode(response.body);
        EasyLoading.showSuccess('Set Default Successfully!');

        getAddressApiCall();
      } else if(response.statusCode == 201){
        EasyLoading.dismiss();
        Map<String, dynamic> results  = jsonDecode(response.body);
        EasyLoading.showSuccess('Set Default Successfully!');

        getAddressApiCall();
      }



      else {
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
        title: Text("MANAGE ADDRESS",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black)),
        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              Navigator.of(context).pop(true);
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

                          Container(
                            height: 50,
                            color: Colors.white,
                            margin: EdgeInsets.only(left: 0, right: 0,bottom: 20),
                            child: Row(

                              children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 16),
                               child: Text(
                                  "SAVED ADDRESS",
                                  style: CustomTextStyle.textFormFieldBold
                                      .copyWith(color:Colors.black,fontSize: 18),
                                ),
                            ),
                              ],
                            ),
                          ),

                          Flexible(

                            child: buildListView(),
                          ),

                          Container(
                              margin: EdgeInsets.only(left: 10, right: 10, top: 0,bottom: 0),



                              child:Column(

                                  mainAxisAlignment: MainAxisAlignment.end,

                                  children: <Widget>[

                                    SizedBox(
                                        height: 4
                                    ),


                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

                                      child: SquareButtonLinearGradient(
                                        buttonText: "ADD NEW ADDRESS".toUpperCase(),
                                        press: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return AddNewAddressMapPage();
                                              },
                                            ),
                                          ).then((value) => setState(() {
                                            getAddressApiCall();
                                          }));
                                        },
                                        width: double.infinity,
                                      ),
                                    )
                                  ])

                          )
                        ],
                      ),
                    ),

                  ],
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
        itemCount: addressDataList.length, itemBuilder: (context, index) {
      return Stack(

        children: <Widget>[

          Container(

              margin: EdgeInsets.only(left: 16, right: 16, top: 5,bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child:Column(
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 8, left: 8, top: 0, bottom: 8),
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(


                              image: DecorationImage(

                                  image:AssetImage("images/my_home_big.png",
                                    /*    image: NetworkImage(_productDetailsList[index].product_pic,*/
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
                                      addressDataList[index].type.toUpperCase(),
                                      style: CustomTextStyle.textFormFieldBold
                                          .copyWith(color:Colors.black,fontSize: 18),
                                    ),

                                  ],
                                ),

                                Container(
                                  padding: EdgeInsets.only(right: 8, top: 8),
                                  child: Text(
                                    addressDataList[index].username +","+addressDataList[index].address +","+addressDataList[index].city +",Pin - "+addressDataList[index].postcode,
                                    maxLines: 3,
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
                          "",
                          style: CustomTextStyle.textFormFieldSemiBold
                              .copyWith(color:Colors.grey[500],fontSize: 14),
                        ),
                        Container(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              GestureDetector(
                              onTap: () {

                                editAddressApiCall(addressDataList[index]);
                        },

                          child: Container(
                            margin: EdgeInsets.only(left: 5, right: 5,bottom: 5),
                              child:addressDataList[index].is_default==0?Text(

                                "SET AS DEFAULT",
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(color:Colors.black,fontSize: 16),
                              ):Text(

                                "SET AS DEFAULT",
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(color:Colors.grey,fontSize: 16),
                              ),
                          ),
                              ),

      GestureDetector(
      onTap: () {
        String _addressId = addressDataList[index].id.toString();
        if (addressDataList[index].is_default==0) {
          deleteAddressApiCall(_addressId);
        }
      },

      child:      Container(

                      margin: EdgeInsets.only(left: 5, right: 5,bottom: 5),
                      child:Text(
                                "DELETE",
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(color:Colors.red,fontSize: 16),
                              ),
                    ),
                    ),




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






























