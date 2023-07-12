
import 'dart:convert';
import 'dart:io';
import 'package:collectpay/Screens/Cart/manage_address_list_page.dart';

import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../appConstants.dart';
import '../../utils/UserPreferences.dart';

class AddNewAddressMapPage extends StatefulWidget {
  @override
  _AddNewAddressMapPageState createState() => _AddNewAddressMapPageState();
}

class _AddNewAddressMapPageState extends State<AddNewAddressMapPage> {


  final LatLng _center = const LatLng(22.5726, 88.3639);

 /* void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }*/


  String _verticalGroupValue = "Home";
  List<String> _status = ["Home", "Office", "Others"];
  Position _currentPosition;
  LatLng latlong = null;
  CameraPosition _cameraPosition;
  GoogleMapController _controller ;
  Set<Marker> _markers={};
  TextEditingController locationController = TextEditingController();

  String postcode = "";
  String myAddress = "";
  String city = "";
  String userToken = "";
  String userName = "";
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userToken = UserPreferences().userCurrentToken;
    userName = UserPreferences().userName;
    _cameraPosition = CameraPosition(target: LatLng(22.5726, 88.3639),zoom: 14.0);
    _getUserLocation();


  }

  // Add Address From Map  Api
  Future<void> addAddressApiCall() async {
    EasyLoading.show(status: 'Please wait...');

    Map<String, String> _requestBody = <String, String>{
      'username':userName,
      'longitude': _currentPosition.longitude.toString(),
      'latitude':  _currentPosition.latitude.toString(),
      'postcode':postcode,
      'address': myAddress,
      'city': city,
      'type': _verticalGroupValue,
      'is_default':'0'
    };

    var _body = json.encode(_requestBody);
    print("request_json=$_body");

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.getAddressList;

    Uri myUri = Uri.parse(url);

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
      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        Map<String, dynamic> results  = jsonDecode(response.body);
        EasyLoading.showSuccess('Address Add Successfully!');
        Navigator.of(context).pop(true);

      }
      else if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Map<String, dynamic> results  = jsonDecode(response.body);
        EasyLoading.showSuccess('Address Add Successfully!');
        Navigator.of(context).pop(true);
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


  void _getUserLocation() async {
    _currentPosition = await _getGeoLocationPosition();

     setState(() {

      _getAddressFromLatLong(_currentPosition);

      latlong = new LatLng(_currentPosition.latitude, _currentPosition.longitude);
      _cameraPosition = CameraPosition(target:latlong,zoom: 10.0 );
      if(_controller!=null)
        _controller.animateCamera(

            CameraUpdate.newCameraPosition(_cameraPosition));
            _markers.add(Marker(markerId: MarkerId("current"),draggable:true,position: latlong,icon: BitmapDescriptor.defaultMarkerWithHue(

          BitmapDescriptor.hueOrange),onDragEnd: (_currentlatLng){
          latlong = _currentlatLng;


      }));

    });
  }
  @override
  Widget build(BuildContext context) {
    //  final Controller c = Get.put(Controller());
    return WillPopScope(
      /*  onWillPop: _onBackPressed,*/
        child: new Scaffold(

            appBar: new AppBar(
              backgroundColor: Colors.white70,
              title: Text("ADD NEW ADDRESS",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black)),
                leading: IconButton(
                    icon:new Image.asset('images/back_icon.png'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    }),
            ),

            body: new  Column(
                children: <Widget>[

                  Expanded(
// Cart item List
                      child:GoogleMap(
                        initialCameraPosition: _cameraPosition,
                        onMapCreated: (GoogleMapController controller){
                          _controller=(controller);
                          _controller.animateCamera(

                              CameraUpdate.newCameraPosition(_cameraPosition));
                        },

                        markers:_markers ,

                      ),
                  ),




                      SingleChildScrollView(

                          child: Container(
                              margin: EdgeInsets.only(left: 16, right: 16, top: 0,bottom: 0),

                              child:Column(

                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    SizedBox(
                                        height: 10
                                    ),
                                    Container(

                                      child: Text(
                                        "Current Address:",
                                        softWrap: true,
                                        style: CustomTextStyle.textFormFieldSemiBold
                                            .copyWith(fontSize: 16,color:Colors.black),
                                      ),
                                    ),

                                    SizedBox(
                                        height: 5
                                    ),

                                    Container(
                                      padding: EdgeInsets.only(right: 8, top: 8),
                                      child: Text(
                                        locationController.text,
                                        maxLines: 3,
                                        softWrap: true,
                                        style: CustomTextStyle.textFormFieldSemiBold
                                            .copyWith(fontSize: 14,color:Colors.grey[500]),
                                      ),
                                    ),



                                    SizedBox(   //Use of SizedBox
                                      height: 10,
                                    ),

                                    RadioGroup<String>.builder(
                                      direction: Axis.horizontal,
                                      groupValue: _verticalGroupValue,
                                      horizontalAlignment: MainAxisAlignment.spaceAround,
                                      onChanged: (value) => setState(() {
                                        _verticalGroupValue = value;
                                      }),
                                      items: _status,

                                      itemBuilder: (item) => RadioButtonBuilder(
                                        item,

                                      ),
                                    ),

                                    SizedBox(   //Use of SizedBox
                                      height: 10,
                                    ),



                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

                                      child: SquareButtonLinearGradient(
                                        buttonText: "CONFIRM ADDRESS".toUpperCase(),
                                        press: () {
                                        /*  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ManageAddressListPage();
                                              },
                                            ),
                                          );*/
                                          addAddressApiCall();
                                        },
                                        width: double.infinity,
                                      ),
                                    )
                                  ])

                          )
                      )


                ]
            )

        )
    );
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


  Future<void> _getAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    String  address =  '${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    locationController.text = address;
    postcode = place.postalCode;
    myAddress  = place.street+","+place.subLocality;
    city = place.locality;
  }


  static getSizedBox({double width, double height}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}


