import 'dart:io';

import 'package:collectpay/Model/RegistrationResponse/CommonResponseRegister.dart';
import 'package:collectpay/Screens/Login/login_screen.dart';
import 'package:collectpay/Screens/OTPScreen/Otp.dart';
import 'package:collectpay/Screens/Signup/components/background.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/MyConnectivity.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:collectpay/utils/already_have_an_account_acheck.dart';
import 'package:collectpay/utils/rounded_button.dart';
import 'package:collectpay/utils/rounded_input_field.dart';
import 'package:collectpay/utils/rounded_input_phone_number_field.dart';
import 'package:collectpay/utils/rounded_password_field.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/io_client.dart';



class Body extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}


class _MyBodyState extends State<Body> {
  bool _connectivityStatus = false;
  MyConnectivity _connectivity = MyConnectivity.instance;
  Position _currentPosition;
  String _currentAddress;

  @override
  initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() =>

          _checkInternetConnection(source));
    });
    _getUserLocation();
  }



  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }


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
        duration: Duration(seconds: 4),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }

  snackBarGreen(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void _getUserLocation() async {
    _currentPosition = await _getGeoLocationPosition();
    EasyLoading.showSuccess('Get Your Current Location');

  }


  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }


/*
  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

  }*/


  @override
  Widget build(BuildContext context) {
    String userName;
    String userEmail;
    String userMobileNo;
    String userPassword;
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.35),

            /* SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),*/

            RoundedInputField(
              hintText: "Name",
              onChanged: (value) {
                userName = value;
              },
            ),

            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {
                userEmail = value;
              },
            ),
            RoundedInputPhoneNumberField(

              hintText: "Phone No",
              onChanged: (value) {
                userMobileNo = value;
              },
            ),
            RoundedPasswordField(

              onChanged: (value) {
                userPassword = value;
              },
            ),
            SquareButtonLinearGradient(

              buttonText: "SIGN UP",
              press: () async {

          /*           Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Otp("9832060802",userPassword.toString(),"123445667890","android");
                    },
                  ),
                );*/

                if(userName!= null && userEmail!= null && userMobileNo!= null && userPassword!= null && userName.isNotEmpty && userEmail.isNotEmpty && userMobileNo.isNotEmpty && userPassword.isNotEmpty){
                  bool isOnline = await hasNetwork();
                  if (isOnline) {
                    _signUp(context,userName,userEmail,userMobileNo,userPassword);
                  } else {
                    snackBarError('Internet Connection Not Available!');
                  }
                }
                else
                  EasyLoading.showError('All fields are mandatory');

              },
              width: size.width * 9,

            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );


  }

  Future<void> _signUp(BuildContext _context,String userName,String userEmail,String userMobileNo,String userPassword) async {
    EasyLoading.show(status: 'Please wait...');
    Map<String, String> _requestBody = <String, String>{
      'type':'user',
      'image':userImage,
      'name': userName,
      'mobile': userMobileNo,
      'email': userEmail,
      'password': userPassword,
      'device_token': '123445667890',
      'device_name': 'android',
      'latitude': _currentPosition.latitude.toString()/*'22.5726'*/,
      'longitude': _currentPosition.longitude.toString()/*'88.3639'*/,
    };

    var _body = json.encode(_requestBody);
    print("request_json=$_body");

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.register;

    Uri myUri = Uri.parse(url);

    final http.Response response  = await httpTemp.post(
        myUri,
        headers:{ "Content-Type": "application/json" } ,
        body: _body,
        encoding: Encoding.getByName("utf-8")
    );


    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      CommonResponseRegister _commonResponseRegisterData = CommonResponseRegister.fromJsonMap(jsonDecode(response.body));
      if (_commonResponseRegisterData.registrationResponseData!=null) {

        print("response_data=$_commonResponseRegisterData");
        EasyLoading.showSuccess('Successfully Register!');

        var mobile = _commonResponseRegisterData.registrationResponseData.mobile;
        print("response_mobile=$mobile");


        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Otp(mobile,userPassword.toString(),"123445667890","android");
            },
          ),
        );

      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Registration Failed!');
      }

    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Registration Failed!, Response Code :'+ response.statusCode.toString());
    }
  }

}
