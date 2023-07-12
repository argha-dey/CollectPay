import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(

        children: <Widget>[
          new Container(
         /*   decoration: new BoxDecoration(
              image: new DecorationImage(image: new AssetImage("images/splashscreen.png"), fit: BoxFit.cover,),
            ),*/
            color: Colors.white,
          ),


          new Align(
            alignment: Alignment(0.0, -0.7),
            child:Image(
                image: AssetImage("images/collect_pay_logo.png"),
                height: 140,
                alignment: Alignment.center,
                width: 200),
          ),

          child,
        ],
      ),
    );
  }
}
