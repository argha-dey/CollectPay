import 'dart:convert';

import 'package:collectpay/Model/ActivePastOrderDetails/ActivePastOrderResponse.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:io';


import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/CustomColors.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyOrderDetailsPage extends StatefulWidget {

  final String orderId;
  const MyOrderDetailsPage({Key key, this.orderId}) : super(key: key);
  @override
  _MyOrderDetailsPageState createState() => _MyOrderDetailsPageState();
}

class _MyOrderDetailsPageState extends State<MyOrderDetailsPage> {

  String userToken = "";
  SharedPreferences sharedPreferences;
  ActivePastOrderData placeOrderData;
  List<ProductDetails> productDetails = [];

   String pdfUrl = "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
   String orderId="";

  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  Directory externalDir;


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

    var url = UrlConstants.placeOrder+"/"+widget.orderId;
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
        ActivePastOrderResponse activePastOrderResponse = ActivePastOrderResponse.fromJson(results);
        setState(() {
          placeOrderData =  activePastOrderResponse.data;
          productDetails = placeOrderData.productDetails;
          pdfUrl = placeOrderData.invoiceUrl;
          orderId = ""+placeOrderData.orderId.toString();
          print("Pdf Invoice Url"+pdfUrl);
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
  Future<void> downloadFile() async {
    Dio dio = Dio();
    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      try {
        FileUtils.mkdir([dirloc]);
        await dio.download(pdfUrl, dirloc + convertCurrentDateTimeToString() + ".pdf",
            onReceiveProgress: (receivedBytes, totalBytes) {

              setState(() {
                downloading = true;
                progress = ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
              });

            });
      } catch (e) {
        print('catch catch catch');
        print(e);
      }

      setState(() {
        downloading = false;
        EasyLoading.showSuccess("Invoice Download Completed. Please check in your downloads directory");
        path = dirloc + convertCurrentDateTimeToString() + ".pdf";
      });
      print(path);

    } else {
      setState(() {
        EasyLoading.showError("Permission Denied!");
        _onPressed = () {
          downloadFile();
        };
      });
    }
  }

  String convertCurrentDateTimeToString() {
    String formattedDateTime = "ORDER_ID"+orderId+"-"+formatDate(DateTime.now(),[yyyy, '-', mm, '-', dd]).toString();
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(

        child: new Scaffold(
            backgroundColor: Color(0xffE5E5E5),
            appBar: AppBar(
              backgroundColor: Colors.white70,
              title: Text(
                "ORDER DETAILS",
                style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color: Colors.black),
              ),

              leading: IconButton(
                  icon:new Image.asset('images/back_icon.png'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              actions: <Widget>[
                InkWell(
                  onTap: () {
                    downloadFile();
                  }, // Image tapped

                  child: Image.asset('images/download_invoice.png',height: 32,width: 32,),
                ),
                Container(padding: const EdgeInsets.all(6.0), child: Text(''))
              ],
            ),

            body: productDetails.length>0? new  Column(
                children: <Widget>[
                  SizedBox(
                      height: 10
                  ),
                  Expanded(
// Cart item List
                      child: buildListView()
                  ),




                  SingleChildScrollView(

                      child: Container(
                          margin: EdgeInsets.only(left: 16, right: 16, top: 5,bottom: 0),



                          child:Column(

                              mainAxisAlignment: MainAxisAlignment.end,

                              children: <Widget>[
                                SizedBox(
                                    height: 10
                                ),
                                Row(

                                  children: <Widget>[
                                    Expanded(

                                      child: Text("Order Id".toUpperCase(),style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.left),
                                    ),
                                    Expanded(

                                      child:Text("Date".toUpperCase(),style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: 10
                                ),
                                Row(

                                  children: <Widget>[
                                    Expanded(

                                      child: Text(placeOrderData.orderDisplayId,style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.black),textAlign: TextAlign.left),
                                    ),
                                    Expanded(

                                      child:Text(placeOrderData.createdAt,style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.black),textAlign: TextAlign.right),
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
                                          color: Colors.black12,
                                          height: 0,
                                        )),
                                  ),

                                  Expanded(
                                    child: new Container(

                                        child: Divider(
                                          color: Colors.black12,
                                          height: 0,
                                        )),
                                  ),
                                ]),

                                SizedBox(   //Use of SizedBox
                                  height: 10,
                                ),

                                Row(

                                  children: <Widget>[
                                    Expanded(

                                      child: Text("Shipping Address".toUpperCase(),style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.left),
                                    ),
                                    Expanded(

                                      child:Text( "",
                                          style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: 15
                                ),
                                Row(

                                  children: <Widget>[
                                    Expanded(

                                      child:Text( placeOrderData.deliveryAddress.username +","+placeOrderData.deliveryAddress.address +","+placeOrderData.deliveryAddress.city +",Pin - "+placeOrderData.deliveryAddress.postcode,
                                          style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.black),textAlign: TextAlign.left),
                                    ),

                                  ],
                                ),

                                SizedBox(
                                    height: 10
                                ),

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(UserPreferences().userMobile,style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.black),textAlign: TextAlign.left),
                                    ),
                                    Expanded(

                                      child:Text(""/*totalServiceTax*/,style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: 8
                                ),
                                Row(children: <Widget>[
                                  Expanded(
                                    child: new Container(

                                        child: Divider(
                                          color: Colors.white,
                                          height: 5,
                                        )),
                                  ),

                                  Expanded(
                                    child: new Container(

                                        child: Divider(
                                          color: Colors.white,
                                          height: 5,
                                        )),
                                  ),
                                ]),
                                SizedBox(
                                    height: 8
                                ),
                                Row(

                                  children: <Widget>[
                                    Expanded(

                                      child: Text("Payment Details".toUpperCase(),style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.left),
                                    ),
                                    Expanded(

                                      child:Text("",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: 15
                                ),
                                Row(

                                  children: <Widget>[
                                    Expanded(

                                      child: Text("Subtotal",style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.black),textAlign: TextAlign.left),
                                    ),
                                    Expanded(

                                      child:Text("SRD "+placeOrderData.subTotalAmount,style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.black),textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                    height: 10
                                ),

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text("Tax",style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.black),textAlign: TextAlign.left),
                                    ),
                                    Expanded(

                                      child:Text("SRD "+placeOrderData.taxAmount,style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.black),textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),

                                SizedBox(   //Use of SizedBox
                                  height: 6,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text("Shipping Charges",style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.black),textAlign: TextAlign.left),
                                    ),
                                    Expanded(

                                      child:Text("SRD "+placeOrderData.otherCharge,style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.black),textAlign: TextAlign.right),
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
                                      child: Text("To Pay",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.left),
                                    ),
                                    Expanded(

                                      child:Text("SRD "+placeOrderData.totalAmount,style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),

                                SizedBox(   //Use of SizedBox
                                  height: 15,
                                ),




                              ])

                      )
                  )


                ]
            ): new  Container(
                child: Center(child: Text("No Data Available!",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color:Colors.blue)))
            )

        )
    );
  }


  ListView buildListView() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: productDetails.length, itemBuilder: (context, index) {
      return Stack(
        children: <Widget>[

          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 5,bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
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
                            productDetails[index].product.image,
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
                            productDetails[index].product.name,
                            maxLines: 2,
                            softWrap: true,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(fontSize: 16,color: Colors.black),
                          ),
                        ),
                        getSizedBox(height: 6),
                        Text(
                          productDetails[index].product.description,
                          style: CustomTextStyle.textFormFieldRegular
                              .copyWith(color: Colors.black, fontSize: 12),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Qty. "+ productDetails[index].product.cartQuantity.toString(),
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(color: Colors.black),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[




                                      Container(

                                        padding: const EdgeInsets.only(
                                            bottom: 2, right: 12, left: 12),
                                        child: Text(
                                          "SRD "+productDetails[index].product.sellingPrice,
                                          style:
                                          CustomTextStyle.textFormFieldSemiBold.copyWith(color:Colors.black),
                                        ) ,
                                      ),



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


