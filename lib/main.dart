import 'package:collectpay/Screens/Onboarding/SlideScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'utils/UserPreferences.dart';


class CartCount with ChangeNotifier {
  CartCount({this.count});
  int count;
  void updateCartCount(int _count) {
    this.count = _count;
    notifyListeners();
  }
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(ChangeNotifierProvider(
    create: (_) => CartCount(count: 0),
    child: MyApp(),
  ),
  );

/*
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider<CartCount>(
        create: (_) =>CartCount(count: 0),
      ),
      ChangeNotifierProvider<ChangeTab>(
        create: (_) => ChangeTab(index: 0),
      ),
    ],
    child: MyApp(),
  ),
  );*/

}



class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  void showNotification(String title, String body) async {
    // await _demoNotification(title, body);
  }





  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white,   /*cursorColor: Colors.blueAccent[800]*/),

      home: SlideScreen(),
      builder: EasyLoading.init(),
    );
  }
}



class Notification {
  final String title;
  final String body;
  final Color color;
  const Notification(
      {@required this.title, @required this.body, @required this.color});
}




