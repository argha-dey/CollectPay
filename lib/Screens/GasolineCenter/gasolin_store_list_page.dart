import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/GasolineCenter/GasolineResponseData.dart';
import 'package:collectpay/Screens/GasolineCenter/gasolin_store_details_page.dart';
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
import '../../appConstants.dart';



class GasolineStoreListPage extends StatefulWidget {
  final String menuCategorySlag;
  const GasolineStoreListPage({Key key, @required this.menuCategorySlag}) : super(key: key);

  @override
  _GasolineStoreListPageState createState() => new _GasolineStoreListPageState();
}

class _GasolineStoreListPageState extends State<GasolineStoreListPage>  {

  final Connectivity _connectivity = Connectivity();
  final List<String> numbers = [];
  List<GasolineData> gasolineDataList = [];
  List<GasolineData> gasolineDataListTemp = [];
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
      this.getGasolineCenterList();
    });
  }



  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<GasolineData> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = gasolineDataList;
      setState(() {
        gasolineDataListTemp = results;
      });
    } else {
      for (int i = 0; i < gasolineDataList.length; i++) {
        if (gasolineDataList[i].shopName.toLowerCase()
            .contains(enteredKeyword.toLowerCase())) {
          results.add(gasolineDataList[i]);
        }
      }
      // Refresh the UI
      setState(() {
        gasolineDataListTemp = results;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
  Future<void> getGasolineCenterList() async {
    EasyLoading.show(status: 'Please wait...');
    var url = UrlConstants.gasolineCenterList;
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
        GasolineResponseData gasolineResponseData = GasolineResponseData.fromJson(results);
        setState(() {
          gasolineDataList = gasolineResponseData.data;
          gasolineDataListTemp = gasolineDataList;
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

        return  Container(

          child: Stack(
            children: <Widget>[
              Container(
                height: 230,
                decoration: BoxDecoration(
                    image: DecorationImage(

                      /*     image: NetworkImage(subCatImage),*/
                      image:AssetImage("images/gasoline_banner_icon.png"),

                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),

              ),
              Container(
                child: Text(
                  "GASOLINE STORE",
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
                              margin: EdgeInsets.only(top: 80, left: 0, right: 0),
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
                                      "NEAR BY GASOLINE STORE",
                                      style: CustomTextStyle.textFormFieldSemiBold
                                          .copyWith(color: CustomColors.kNearbyTextLevelColor, fontSize: 16),overflow: TextOverflow.ellipsis,
                                    ),),

                                  gasolineDataListTemp.length>0?Flexible(

                                    child: buildListView(),

                                  ): new  Container(
                                      margin: const EdgeInsets.only(top:100),
                                      child: Center(child: Text("No Gasoline Center Available!",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color:Colors.black)))),

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
        itemCount: gasolineDataListTemp.length, itemBuilder: (context, index) {
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

                         /*   image:AssetImage("images/gasolin_icon.png",*/
                                  image: NetworkImage(gasolineDataListTemp[index].shopPhoto,
                            ), fit: BoxFit.cover)
                    )),

                Expanded(
                  child: new InkWell(
                    onTap: () {

                      int gasolineCenterId = gasolineDataListTemp[index].shopId;
                      String gasolineName = gasolineDataListTemp[index].shopName;
                      print("tapped gasolineCenterId =>  $gasolineCenterId");
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => GasolineStoreDetailsPage(gasolineCenterId:gasolineCenterId.toString(),gasolineName: gasolineName,)));

                    },

                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 8, top: 0,bottom: 4),
                            child: Text(
                              gasolineDataListTemp[index].shopName.toUpperCase(),
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(fontSize: 14,color:Colors.black),
                            ),
                          ),
                          getSizedBox(height: 5),
                          Text(
                            gasolineDataListTemp[index].shopAddress,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyle.textFormFieldRegular
                                .copyWith(color:Colors.black, fontSize: 12),
                          ),
                          getSizedBox(height: 10),
                          gasolineDataListTemp[index].itemPrice.length>0? Text(gasolineDataListTemp[index].itemPrice[0].name.toUpperCase()  +":  "+gasolineDataList[index].itemPrice[0].price + "/L" ,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(color:Colors.black,fontSize: 12),
                          ):Text("Not Available!" ,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(color:Colors.black,fontSize: 12),
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
















