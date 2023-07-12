import 'package:collectpay/Screens/Profile/WebViewStack.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {


  @override
  void initState() {
    WebView.platform = SurfaceAndroidWebView();
    super.initState();
    setState(() {
    //  this.aboutUsDetailsApi();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          "About Us",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color: Colors.black),
        ),
        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
      ),
      body:WebViewStack(urlString:'https://collectpay.developerconsole.live/api/about-us'),
    );
  }





  /*Future <void> aboutUsDetailsApi() async{


    String url = base_url_api+"?key="+api_Key+"&getType="+getAboutUsContent;
    EasyLoading.show(status: 'Please wait...');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      EasyLoading.dismiss();

      Map<String, dynamic> getMyRawJson = jsonDecode(response.body);
      CommonAboutUsResponse _commonResponse = CommonAboutUsResponse.fromJson(getMyRawJson);
      if (_commonResponse.success) {
        setState(() {
            dataList = List<CategoriesListResponseData>.from(getMyRawJson["aboutusdata"].map((p) => CategoriesListResponseData.fromJson(p)));
            aboutUsContent = dataList[0].about_us_content;
        });

      }
    }
    else {
      //  EasyLoading.dismiss();
      throw Exception('Failed to parse json');
    }

  }*/
}
