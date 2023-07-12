import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/GasolineCenter/GasolineCenterDetailsResponseData.dart';
import 'package:collectpay/Screens/SuperMarket/super_market_category_page.dart';
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



class GasolineStoreDetailsPage extends StatefulWidget {
  final String gasolineCenterId;
  final String gasolineName;
  const GasolineStoreDetailsPage({Key key, this.gasolineCenterId,this.gasolineName}) : super(key: key);

  @override
  _GasolineStoreDetailsPageState createState() => new _GasolineStoreDetailsPageState();
}

class _GasolineStoreDetailsPageState extends State<GasolineStoreDetailsPage>  {

  final Connectivity _connectivity = Connectivity();
  final List<String> numbers = [];
  GasolineDetailsData gasolineDetailsData;
  List<ItemPrice> itemPriceData = [];
  String searchText = "";
  TextEditingController _editingController;
  String select;
  String userToken = "";
  SharedPreferences sharedPreferences;



  @override
  void initState() {
    super.initState();
    setState(() {
      EasyLoading.dismiss();
      userToken = UserPreferences().userCurrentToken;
      this.getGasolineCenterDetails();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getGasolineCenterDetails() async {
    EasyLoading.show(status: 'Please wait...');
    var url = UrlConstants.gasolineCenterDetails + widget.gasolineCenterId;
    print('Token : ${userToken}');
    print('url : ${url}');

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
        GasolineCenterDetailsResponseData gasolineCenterDetailsResponseData = GasolineCenterDetailsResponseData.fromJson(results);
        setState(() {
          gasolineDetailsData = gasolineCenterDetailsResponseData.data;
          itemPriceData = gasolineCenterDetailsResponseData.data.itemPrice;
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

      body: Builder(builder: (context) {

        return Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 30,

                child: Stack(

                  children: <Widget>[
                    Container(
                      height: 230,
                      decoration: BoxDecoration(
                          image: DecorationImage(

                            /*     image: NetworkImage(subCatImage),*/
                            image:AssetImage("images/gasoline_banner_icon.png"),

                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0))),

                    ),
                    Container(
                      child: Text(
                        "GASOLINE STORE DETAILS",
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

                  ],
                ),
              ),

              gasolineDetailsData!=null? new Expanded(
                flex: 40,
                child: Column(

                  children: <Widget>[
                    Column(


                      children: <Widget>[

                        Container(
                          child: Card(

                            shape: RoundedRectangleBorder(
                              borderRadius:BorderRadius.only(
                                topLeft: Radius.circular(6.0),
                                topRight: Radius.circular(6.0),
                                bottomLeft: Radius.circular(6.0),
                                bottomRight: Radius.circular(6.0),

                              ),
                            ),

                            child: Column(

                              children: <Widget>[



                                Container(

                                  margin: EdgeInsets.only(left: 10, right: 10,),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(right: 8, left: 8, bottom: 8),
                                          width: 86,
                                          height: 86,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(14)),
                                              image: DecorationImage(

                                             /*     image:AssetImage("images/gasolin_icon.png",*/
                                                        image: NetworkImage(gasolineDetailsData.shopPhoto,
                                                  ), fit: BoxFit.scaleDown)
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
                                                    gasolineDetailsData.shopName.toUpperCase(),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    style: CustomTextStyle.textFormFieldSemiBold
                                                        .copyWith(fontSize: 12,color:Colors.black),
                                                  ),
                                                ),
                                                getSizedBox(height: 5),
                                                Text(
                                                  gasolineDetailsData.shopAddress,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  style: CustomTextStyle.textFormFieldRegular
                                                      .copyWith(color:Colors.black, fontSize: 12),
                                                ),

                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      itemPriceData.length>0? Text(itemPriceData[0].name.toUpperCase()  +":  "+itemPriceData[0].price + "/L" ,
                                                        style: CustomTextStyle.textFormFieldSemiBold
                                                            .copyWith(color:Colors.black,fontSize: 12),
                                                      ):Text("Not Available!",
                                                        style: CustomTextStyle.textFormFieldSemiBold
                                                            .copyWith(color:Colors.black,fontSize: 12),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 0.0, bottom: 0.0,left: 5.0,right: 0.0),


                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: <Widget>[






                                                            Container(
                                                              margin: EdgeInsets.only(  bottom: 2, right: 12, left: 12 ),
                                                              decoration: BoxDecoration(

                                                                  image: DecorationImage(
                                                                      image:AssetImage("images/location_icon.png"),
                                                                      fit: BoxFit.cover)
                                                              ),
                                                              width: 40,
                                                              height: 40,
                                                            ),

                                                            // Add Icon

                                                          ],
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
                            ),

                          ),

                        ),

                        Container(
                          child:   Column(

                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[

                              SizedBox(height:15),

                              Container(

                                margin: EdgeInsets.only(left: 16, right: 16,),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "DESCRIPTION",
                                  style: CustomTextStyle.textFormFieldSemiBold
                                      .copyWith(color: CustomColors.kNearbyTextLevelColor, fontSize: 16),overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              SizedBox(height:10),

                              Container(

                                margin: EdgeInsets.only(left: 16, right: 16,),
                                alignment: Alignment.centerLeft,
                                child: Text(gasolineDetailsData.shopDescription,
                                         style: CustomTextStyle.textFormFieldRegular
                                      .copyWith(color: Colors.black, fontSize: 12),overflow: TextOverflow.ellipsis,maxLines: 4,
                                ),
                              ),
                              SizedBox(height:15),

                              Container(

                                margin: EdgeInsets.only(left: 16, right: 16),
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "TODAY RATE",
                                  style: CustomTextStyle.textFormFieldSemiBold
                                      .copyWith(color: CustomColors.kNearbyTextLevelColor, fontSize: 16),overflow: TextOverflow.ellipsis,
                                ),
                              ),

                            ],
                          ),

                        ),



                      ],
                    ),

                  ],),):new Container(),

          itemPriceData.length>0? new Expanded(
                flex: 30,
                child: buildListView(),
              ):new Container(),





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
        itemCount: itemPriceData.length, itemBuilder: (context, index) {
      return Stack(

        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15,right: 15,bottom: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),

                ),
              ),

              child: Column(

                children: <Widget>[



                  Container(

                    margin: EdgeInsets.only(left: 12, right: 12,),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: <Widget>[


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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(itemPriceData[index].name.toUpperCase()  +":    "+itemPriceData[index].price + "/L" ,

                                          style: CustomTextStyle.textFormFieldSemiBold
                                              .copyWith(color:Colors.black,fontSize: 14),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 0.0, bottom: 0.0,left: 5.0,right: 0.0),


                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[






                                              Container(
                                                margin: EdgeInsets.only(  bottom: 2, right: 12, left: 12 ),

                                                width: 40,
                                                height: 40,
                                              ),

                                              // Add Icon

                                            ],
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
                  ),

                  getSizedBox(height: 5),
                ],
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













addRadioButton(BuildContext superContext, int i, String s) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[


    ],
  );
}
















