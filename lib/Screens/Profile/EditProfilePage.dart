import 'dart:io';
import 'package:collectpay/Model/ProfileResponse/ProfileDataResponse.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:collectpay/utils/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File _image;
  ProfileData profileDataDetails;
  String userName ="";
  String userEmail = "";
  String userMobile ="";
  String base64Image = "";
  String userToken = "";
  String imageUrl = "";
  SharedPreferences sharedPreferences;
  ImagePicker picker;

  @override
  void initState() {
    // TODO: implement initState
    userToken = UserPreferences().userCurrentToken;
    picker = ImagePicker();

    this.profileGetDataApi();

    super.initState();
  }


  // Add Address  Details Api
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
          userName = profileDataDetails.name;
          userEmail = profileDataDetails.email;
          userMobile = profileDataDetails.mobile;
          if (profileDataDetails.image!=null) {
            imageUrl = profileDataDetails.image;
         //   base64Image =   networkImageToBase64(imageUrl);
          }

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


  Future<void> profilePostDataApi() async {
    EasyLoading.show(status: 'Please wait...');


    Map<String, dynamic> _requestBody;

    if (base64Image!="") {
      _requestBody = <String, dynamic>{
        'name':userName,
        'email': userEmail,
        'mobile':userMobile,
        'image':base64Image,
      };

    } else{
      _requestBody = <String, dynamic>{
        'name':userName,
        'email': userEmail,
        'mobile':userMobile,
      };

    }







    var _body = json.encode(_requestBody);
    print("request_json=$_body");

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.getProfile;

    Uri myUri = Uri.parse(url);
    print("myUri=$myUri");
    
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
        EasyLoading.showSuccess("Successfully Update");
        Navigator.of(context).pop(true);

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Edit Profile",
          style: CustomTextStyle.textFormFieldBlack.copyWith(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(

        child: Column(
          children: <Widget>[
            SizedBox(
              height: 24,
            ),
            Stack(
              children: <Widget>[

                Center(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar(
        radius: 55,

        child: _image != null ? ClipRRect(
          borderRadius: BorderRadius.circular(55),

          child: Image.file(
            _image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),


        )  :  imageUrl.isEmpty? Container(decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(55)),
          width: 100,
          height: 100,
          child: Icon(
            Icons.person_rounded,
            color: Colors.grey,
          ),
        ):  Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.brown,width: 1),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                  imageUrl,
                  ),
                  fit: BoxFit.cover)),
          width: 100,
          height: 100,
        ),

      ),
                  ),
                )
              ],
            ),

            Container(
              child: RoundedInputField(

                  hintText: "Enter Name",
                controller: TextEditingController(text: userName),
                onChanged: (value) {
                  //  print("Your Email entered is : $value");
                  userName = value;
                },

              ),

            ),

            Container(
              child: RoundedInputField(

                    hintText:  "Enter Email Id",
                controller: TextEditingController(text: userEmail),
                onChanged: (value) {
                  //  print("Your Email entered is : $value");
                  userEmail = value;
                },
              ),

            ),
            Container(
              child: RoundedInputField(

                hintText:  "Enter Mobile Number",
                controller: TextEditingController(text: userMobile),
                onChanged: (value) {
                  //  print("Your Email entered is : $value");
                  userMobile = value;
                },
              ),

            ),
          ],

        ),
      ),

      bottomNavigationBar:profileDataDetails!=null ? SizedBox(

        child: Container(
            margin: EdgeInsets.only(left: 4, right: 4, bottom: 2),

            child:  SquareButtonLinearGradient(
              buttonText: "Update".toUpperCase(),
              press: () {
                profilePostDataApi();
              },
              width: double.infinity,
            )
        ),
      ): new Container(),


    );

  }

  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.grey));


  Future<void> _showPicker(context) async {
    await Permission.camera.request();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  _imgFromCamera() async {
    XFile image = await picker.pickImage(
        source: ImageSource.camera, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
    setState(() {
      _image = File(image.path);

      List<int> imageBytes = _image.readAsBytesSync();
 //     print("mimeType: "+mimeType);

      String imgType = image.path.split('.').last;
      print("imgType: "+imgType);
      if (imgType == 'jpg'){
        base64Image = 'data:image/jpg;base64,'+base64Encode(imageBytes);
      }else if(imgType == 'jpeg'){
        base64Image = 'data:image/jpeg;base64,'+base64Encode(imageBytes);
      }else if (imgType == 'png'){
        base64Image = 'data:image/png;base64,'+base64Encode(imageBytes);
      }

      print("base64Image: "+base64Image);

    });
  }

  _imgFromGallery() async {
    XFile image = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = File(image.path);
     // String mimeType = image.mimeType.toString();
      List<int> imageBytes = _image.readAsBytesSync();
      String imgType = image.path.split('.').last;
      print("imgType: "+imgType);
      if (imgType == 'jpg'){
        base64Image = 'data:image/jpg;base64,'+base64Encode(imageBytes);
      }else if(imgType == 'jpeg'){
        base64Image = 'data:image/jpeg;base64,'+base64Encode(imageBytes);
      }else if (imgType == 'png'){
        base64Image = 'data:image/png;base64,'+base64Encode(imageBytes);
      }
      print("base64Image: "+base64Image);
    });

  }

 networkImageToBase64(String _imageUrl) async {
    Uri myUri = Uri.parse(_imageUrl);
    print("myUri=$myUri");
    http.Response response = await http.get(myUri);
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }
}
