import 'dart:convert';
import 'dart:io';
import 'package:collectpay/Screens/Budget/budget_category_page.dart';
import 'package:collectpay/Screens/Landing/changeBottomNavigationIndex.dart';
import 'package:collectpay/Screens/Landing/landing_page.dart';
import 'package:collectpay/Screens/Wallet/qr_code_send_money_any_person.dart';
import 'package:collectpay/Screens/Wallet/send_money_history_list_page.dart';
import 'package:collectpay/Screens/Wallet/wallet_page.dart';
import 'package:collectpay/main.dart';
import 'package:http/http.dart' as http;
import 'package:collectpay/Model/Menu.dart';
import 'package:collectpay/Model/ProfileResponse/ProfileDataResponse.dart';
import 'package:collectpay/Screens/GasolineCenter/gasolin_store_list_page.dart';
import 'package:collectpay/Screens/SuperMarket/super_market_list_page.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/CustomColors.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/MyConnectivity.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
class HomePage extends StatefulWidget {

  const HomePage({Key key,  this.changePage}) : super(key: key);
  final void Function(int) changePage;


  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {



  bool _connectivityStatus = false;

  ProfileData profileDataDetails;
  String userToken = "";
  String walletBalance = "0";
  String profileImage ="";
  @override
  initState() {
    super.initState();
    //   UserPreferences().userCurrentToken = "16|IIiKZTC5lOFt5xszEiFtGqgDT1aFB1g5JgIivxYm";
    //UserPreferences().userName = "Argha Dey";
    userToken = UserPreferences().userCurrentToken;
    EasyLoading.dismiss();
    this.profileGetDataApi();
  }

  final List<Menu> _menuCategoryDetails = [
    Menu("SUPER MARKET","0","SM","images/shop_icon.png"),
    Menu("GASOLINE STATION","1","GS","images/gasoline_icon.png"),
    Menu("MY WALLET","2","MW","images/my_wallet_icon.png"),
    Menu("MY BUDGET","3","MB","images/budget_icon.png"),
    Menu("PAYMENT","4","PAY","images/payment_icon.png"),
    Menu("QR SCANNER","5","QR","images/qr_code_scan_icon.png"),
  ];


  Future<void> _checkInternetConnection(Map source) async{

    String status = "Offline";
    switch (source.keys.toList()[0]) {
      case ConnectivityResult.none:
        status = "Internet Connection Not Available!";
        snackBarError(status);
        _connectivityStatus = false;

        break;
      case ConnectivityResult.mobile:
        status = "Internet Connection Available";
        snackBarGreen(status);
        _connectivityStatus = true;
        break;
      case ConnectivityResult.wifi:
        status = "Internet Connection Available";
        snackBarGreen(status);
        _connectivityStatus = true;
        break;
    }
  }


  // snackBar Widget
  snackBarError(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
  snackBarGreen(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  // profile  Details Api
  Future<void> profileGetDataApi() async {
    EasyLoading.show(status: 'Please wait...');

    var url = UrlConstants.getProfile;
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
        ProfileDataResponse  profileDataResponse = ProfileDataResponse.fromJson(results);
        setState(() {
          profileDataDetails = profileDataResponse.data;
          walletBalance = profileDataDetails.walletBalance.toString();
          profileImage = profileDataDetails.image;
        });
        UserPreferences().userCurrentId = profileDataDetails.userId.toString();
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
    //_connectivity.disposeStream();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: new SafeArea(
        //I didnt add appbar. this will add necessary padding for status bar.
        child: new Column(
          children: [

            new Container(
              width:  size.width * 1,
              height: 300,
              margin: EdgeInsets.only(left: 0, right: 0),
              alignment: Alignment.center,
              child: ClipPath(
                clipper: WaveClipper(),
                child: SizedBox(
                  width:  size.width * 1,
                  height: 300,
                  child: new Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          colors: [
                            CustomColors.kButtonGradientColorTwo,
                            CustomColors.kButtonGradientColorOne,

                          ],
                        ),


                      ),
                      child: Column(

                        children: <Widget>[

                          SizedBox(height:10),
                          Align(
                            alignment: Alignment.topRight,

                            child: Container(
                              margin: EdgeInsets.only(left: 0, right: 16),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 0),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                   /*   image:AssetImage("images/ic_user_profile.png"),*/
                                      image: NetworkImage(
                                        profileImage,
                                      ),
                                      fit: BoxFit.cover)
                              ),
                              width: 60,
                              height: 60,
                            ),
                          ),

                          new Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "WALLET BALANCE",
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(color: Colors.white, fontSize: 16),overflow: TextOverflow.ellipsis,
                            ),),
                          SizedBox(height:10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              new Container(
                                margin: const EdgeInsets.only(left: 20.0,top: 10.0),

                                child: Text(
                                  "SRD",
                                  style: CustomTextStyle.textFormFieldBold
                                      .copyWith(color: Colors.white, fontSize: 26),overflow: TextOverflow.ellipsis,
                                ),),



                              new Container(
                                margin: const EdgeInsets.only(left: 10.0),

                                child: Text(
                                  walletBalance,
                                  style: CustomTextStyle.textFormFieldBold
                                      .copyWith(color: Colors.white, fontSize: 40),overflow: TextOverflow.ellipsis,
                                ),),



                            ],
                          ),

                          Row(

                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[

                              Container(
                                margin: EdgeInsets.only(left: 0, right: 25 ),
                                decoration: BoxDecoration(

                                    image: DecorationImage(
                                        image:AssetImage("images/send_icon.png"),
                                        fit: BoxFit.cover)
                                ),
                                width: 40,
                                height: 40,
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 0, right: 25),
                                decoration: BoxDecoration(

                                    image: DecorationImage(
                                        image:AssetImage("images/add_icon.png"),
                                        fit: BoxFit.cover)
                                ),
                                width: 40,
                                height: 40,
                              ),
                            ],

                          ),
                          SizedBox(height:8),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[

                              Container(
                                margin: EdgeInsets.only(left: 0, right: 32 ),
                                child:Text(
                                  "SEND",
                                  style: CustomTextStyle.textFormFieldRegular
                                      .copyWith(color: Colors.white, fontSize: 14),overflow: TextOverflow.ellipsis,
                                ),),


                              Container(
                                margin: EdgeInsets.only(left: 0, right: 30),
                                child:Text(
                                  "ADD",
                                  style: CustomTextStyle.textFormFieldRegular
                                      .copyWith(color: Colors.white, fontSize: 14),overflow: TextOverflow.ellipsis,
                                ),),

                            ],

                          ),
                          SizedBox(height:10),
                        ],
                      )
                  ),
                ),
              ),
            ),

            new Container(
              margin: const EdgeInsets.only(left: 20.0,bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                "WELCOME TO COLLECT PAY",
                style: CustomTextStyle.textFormFieldBold
                    .copyWith(color: Colors.black, fontSize: 16),overflow: TextOverflow.ellipsis,
              ),),



            new Expanded(

              child: new Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 0.0,bottom: 10.0),

                child: GridView.count(
                  crossAxisCount: 2,
                  children:List.generate(_menuCategoryDetails.length, (int _index_position) => Card(
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      side: new BorderSide(color:  Colors.white, width: 0.0),
                      borderRadius: BorderRadius.circular(8.0),

                    ),
                    clipBehavior: Clip.antiAlias,

                    child: new InkWell(


                        onTap: ()  async{

                          String menuCategorySlag = _menuCategoryDetails[_index_position].categorySlag;
                          print("tapped categoryId =>  $menuCategorySlag");
                          if (menuCategorySlag=="SM") {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  SuperMarketListPage(menuCategorySlag: menuCategorySlag)),
                            );


                          }

                          else  if(menuCategorySlag=="GS"){

                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => GasolineStoreListPage(menuCategorySlag: menuCategorySlag)));

                          }

                          else  if (menuCategorySlag=="QR") {

                            String codeSanner = await scanner.scan();

                            if (codeSanner!=null) {

                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return QrCodeSendMoneyAnyPersonPage(userContactData: codeSanner); // My Main page
                                },
                              ),
                              ).then((value) => setState((){
                                this.profileGetDataApi();
                              }));
                            }


                          }

                          else if(menuCategorySlag=="PAY"){

                            pushNewScreen(
                              context,
                              screen: MyMainPage(currentPage: "Page3",selectedIndex:2),
                              withNavBar: false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );



                          }

                          else if(menuCategorySlag=="MW"){

                            pushNewScreen(
                              context,
                              screen: MyMainPage(currentPage: "Page3",selectedIndex:2),
                              withNavBar: false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );




                          }

                          else if(menuCategorySlag=="MB"){
                            pushNewScreen(
                              context,
                              screen: MyMainPage(currentPage: "Page2",selectedIndex:1),
                              withNavBar: false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );


                          }



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
                                      image: AssetImage(_menuCategoryDetails[_index_position].categoryMenuImage,),
                                      fit: BoxFit.scaleDown,
                                    ),

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
                                        _menuCategoryDetails[_index_position].menuTitle,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,
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
                  ), // TODO: Length of Array
                  // Replace

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height-100);
    path.quadraticBezierTo(size.width / 4, size.height / 2, size.width / 2, size.height-100);
    path.quadraticBezierTo(size.width-(size.width / 4),size.height-50, size.width,size.height-100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}



/*List<Card> _buildGridCards(List<Menu> menuCategoryDetails,BuildContext context) {
  int count =  (menuCategoryDetails == null) ? 0 : menuCategoryDetails.length;

  List<Card> cards = List.generate(count, (int _index_position) => Card(
    margin: EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      side: new BorderSide(color:  Colors.white, width: 0.0),
      borderRadius: BorderRadius.circular(8.0),

    ),
    clipBehavior: Clip.antiAlias,

    child: new InkWell(


        onTap: () async{

          String menuCategorySlag = menuCategoryDetails[_index_position].categorySlag;
          print("tapped categoryId =>  $menuCategorySlag");
          if (menuCategorySlag=="SM") {

            *//*       pushNewScreen(
            context,
            screen:SuperMarketListPage(menuCategorySlag: menuCategorySlag),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );*//*

            *//*   pushNewScreenWithRouteSettings(
            context,
            settings: RouteSettings(),
            screen: SuperMarketListPage(menuCategorySlag: menuCategorySlag),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );*//*


            *//*  pushNewScreen(
            context,
            screen:SuperMarketListPage(menuCategorySlag: menuCategorySlag),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );*//*
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  SuperMarketListPage(menuCategorySlag: menuCategorySlag)),
            );

*//*
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => SuperMarketListPage(menuCategorySlag: menuCategorySlag)));*//*
          }
          else  if(menuCategorySlag=="GS"){
            *//*      pushNewScreen(
            context,
            screen:GasolineStoreListPage(menuCategorySlag: menuCategorySlag),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );*//*

            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => GasolineStoreListPage(menuCategorySlag: menuCategorySlag)));
            *//*     pushNewScreen(
          context,
          screen:GasolineStoreListPage(menuCategorySlag: menuCategorySlag),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );*//*

          }
          else  if (menuCategorySlag=="QR") {

            String codeSanner = await scanner.scan();

            if (codeSanner!=null) {

              *//*   pushNewScreen(
                context,
                screen:QrCodeSendMoneyAnyPersonPage(userContactData: codeSanner),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );*//*
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return QrCodeSendMoneyAnyPersonPage(userContactData: codeSanner); // My Main page
                },
              ),
              );
            }


          }

          else if(menuCategorySlag=="PAY"){
            *//*   Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  SuperMarketListPage(menuCategorySlag: menuCategorySlag)),
          );*//*

            *//*   pushNewScreen(
            context,
            screen:WalletPage(menuCategorySlag: menuCategorySlag),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );*//*


          }


          else if(menuCategorySlag=="MW"){


            //new ChangeIndexOfNavBar().sendIndex(2);
            *//*       pushNewScreen(
          context,
          screen:WalletPage(menuCategorySlag: menuCategorySlag),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );*//*
          }
          else if(menuCategorySlag=="MB"){
            *//*    pushNewScreen(
            context,
            screen:BudgetPage(menuCategorySlag: menuCategorySlag),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );*//*
          }

        },

        child: new Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 30.0,bottom: 5.0),
          child: Column(
            children: <Widget>[

              Expanded(

                *//*child: Image.network(
                  _menuCategoryDetails[_index_position].image,
                  fit: BoxFit.cover,
                ),*//*


                child: Container(

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(menuCategoryDetails[_index_position].categoryMenuImage,),
                      fit: BoxFit.scaleDown,
                    ),

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
                        menuCategoryDetails[_index_position].menuTitle,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,
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
}*/
getSizedBox({double width, double height}) {
  return SizedBox(
    height: height,
    width: width,
  );
}



