
import 'dart:convert';
import 'dart:io';
import 'package:collectpay/Model/ProfileResponse/ProfileDataResponse.dart';
import 'package:collectpay/Screens/Profile/AboutUsPage.dart';
import 'package:collectpay/Screens/Profile/ContactPage.dart';
import 'package:collectpay/Screens/Profile/EditProfilePage.dart';
import 'package:collectpay/Screens/Profile/InviteFriendsPage.dart';
import 'package:collectpay/Screens/Profile/MyQrCodePage.dart';
import 'package:collectpay/Screens/Profile/NotificationPage.dart';
import 'package:collectpay/Screens/Profile/my_order_list_page.dart';
import 'package:collectpay/Screens/Welcome/welcome_screen.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/RoundedButtonLinearGradient.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'list_profile_section.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePage1State createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage> {
  List<ListProfileSection> listSection = new List();


  ProfileData profileDataDetails;
  String userToken = "";
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState

    createListItem();
    setState(() {
      userToken = UserPreferences().userCurrentToken;
      this.profileGetDataApi();
    });
    super.initState();
  }

/*  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getString("USER_ID");
    });
  }*/

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
        });

      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
    }
  }

  void createListItem() {
    listSection.add(createSection("View Orders".toUpperCase(), "images/ic_payment.png", Colors.black,MyOrderListPage()));
    listSection.add(createSection("My QR Code".toUpperCase(), "images/qr_code_scanner.png", Colors.black,MyQrCodePage()));
    listSection.add(createSection("Notifications".toUpperCase(), "images/ic_notification.png", Colors.black, NotificationPage()));
    listSection.add(createSection("Invite Friends".toUpperCase(), "images/ic_invite_friends.png", Colors.black, InviteFriendsPage()));
    listSection.add(createSection("About Us".toUpperCase(), "images/ic_about_us.png", Colors.black, AboutPage()));
    listSection.add(createSection("Contact".toUpperCase(), "images/ic_about_us.png", Colors.black,ContactPage()));

  }

  createSection(String title, String icon, Color color, Widget widget) {
    return ListProfileSection(title, icon, color, widget);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  new Scaffold(
          backgroundColor: Colors.grey.shade200,
          resizeToAvoidBottomInset: true,
          body: Builder(builder: (context) {
            return 1>0 ? new Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white70.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),

                  ),
                  GestureDetector(
                      onTap: (){

                      },
                      child:Container(

                  /*  child: Container(

                        margin: EdgeInsets.only( top: 30,left: 6),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            image: DecorationImage(

                                image:AssetImage("images/back_icon.png",
                                  *//*    image: NetworkImage(_productDetailsList[index].product_pic,*//*
                                ), fit: BoxFit.cover)
                        )),*/
                    child:Text(
                      "Profile".toUpperCase(),
                      style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 20,color: Colors.black),
                    ),
                        margin: EdgeInsets.only(top: 45, left: 20),


                  )),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                        flex: 20,
                      ),
                      profileDataDetails!=null ? new Expanded(
                        child: Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                child: Card(
                                  margin:
                                  EdgeInsets.only(top: 50, left: 16, right: 16),
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 8, top: 8, right: 8, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Container(

                                              ),
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                color: Colors.black,
                                                iconSize: 30,
                                                onPressed: () {
                                                     Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditProfilePage())).then((value) => setState(() {
                                                      profileGetDataApi();
                                                     }));
                                                },
                                              )
                                            ],
                                          ),
                                        ),

                                        Text(profileDataDetails.name.toUpperCase(),
                                          style: CustomTextStyle.textFormFieldBlack
                                              .copyWith(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10,bottom: 10),
                                          child: Text(
                                            profileDataDetails.email,
                                            style: CustomTextStyle.textFormFieldBlack
                                                .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          height: 2,
                                          width: double.infinity,
                                          color: Colors.grey.shade200,
                                        ),

                                        buildListView(),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.brown, width: 1),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                         /* image:AssetImage("images/ic_user_profile.png"),*/
                                             image: NetworkImage(
                                               profileDataDetails.image,
                                      ),
                                          fit: BoxFit.cover)),
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RoundedButtonLinearGradient(
                                  buttonText: "Logout".toUpperCase(),
                                  press: () {
                                    UserPreferences().userLoginStatus = false;
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                    pushNewScreen(
                                      context,
                                      screen: WelcomeScreen(),
                                      withNavBar: false, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                    );
                                  /*  Navigator.pushAndRemoveUntil<dynamic>(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) => LoginScreen(),
                                      ),
                                          (route) => false,//if you want to disable back feature set to false
                                    );*/
/*
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (BuildContext context) =>WelcomeScreen()));*/

                                 /*   Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) => WelcomeScreen()),
                                        ModalRoute.withName('/'));*/
                                  },
                                  width: 200,
                                ),
                              ),
                            ],
                          ),
                        ),
                        flex: 75,
                      ):new Container(),
                      Expanded(
                        child: Container(),
                        flex: 05,
                      )
                    ],
                  )
                ],
              ),

            ): new Container();
          }),
        );
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return createListViewItem(listSection[index]);
      },
      itemCount: listSection.length,
    );
  }

  createListViewItem(ListProfileSection listSection) {
    return Builder(builder: (context) {
      return InkWell(
        splashColor: Colors.brown.shade100,
        onTap: () {

          if (listSection.widget != null) {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => listSection.widget));
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 12),
          padding: EdgeInsets.only(top: 6, bottom: 6),
          child: Row(
            children: <Widget>[
              Image(
                image: AssetImage(listSection.icon),
                width: 16,
                height: 16,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                listSection.title,
                style: CustomTextStyle.textFormFieldBold
                    .copyWith(color: Colors.black),
              ),
              Spacer(
                flex: 1,
              ),
              Icon(
                Icons.navigate_next,
                color: Colors.black,
              )
            ],
          ),
        ),
      );
    });
  }


  _onChanged(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setBool("LOGIN_STATUS", value);
      sharedPreferences.commit();
    });
  }
  Future<bool> _onBackPressed() {
 /*   Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return MyMainPage(); // My Main page
      },
    ),
    );*/
  }
}


