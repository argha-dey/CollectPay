

import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:flutter/material.dart';
class SendMoneyDonePage extends StatefulWidget {
  @override
  _SendMoneyDonePageState createState() => _SendMoneyDonePageState();
}

class _SendMoneyDonePageState extends State<SendMoneyDonePage> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(

      backgroundColor: Color(0xffD4FFF9),


      body: Container(

        child: Column(


          children: <Widget>[
            Expanded(
              flex: 45,

              child: Stack(

                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only( top: 30,left: 6),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          image: DecorationImage(

                              image:AssetImage("images/back_icon.png",
                                /*    image: NetworkImage(_productDetailsList[index].product_pic,*/
                              ), fit: BoxFit.cover)
                      )),

                  Container(
                    height: 240,
                    margin: EdgeInsets.only(top: 80, left: 12,right: 12),

                    decoration: BoxDecoration(
                        image: DecorationImage(

                          /*     image: NetworkImage(subCatImage),*/
                          image:AssetImage("images/onboarding_one.png"),

                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),

                  ),


                ],
              ),
            ),

            Expanded(
              flex: 55,

              child:Container(

                child:   Stack(


                  children: <Widget>[



                    Container(

                      margin: EdgeInsets.only(bottom:100,left: 16, right: 16,),
                      alignment: Alignment.center,
                      child: Text(
                        "Thank You",
                        style: CustomTextStyle.textFormFieldSemiBold
                            .copyWith(color: Colors.black, fontSize: 18),overflow: TextOverflow.ellipsis,
                      ),
                    ),


                    Container(
                      margin: EdgeInsets.only(top:0,left: 16, right: 16,),
                      alignment: Alignment.center,
                      child:Row(

                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 4.0),

                            child: Text(
                              "Recharge for your wallet ",
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(color: Colors.black, fontSize: 18),overflow: TextOverflow.ellipsis,
                            ),),

                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

                        child: SquareButtonLinearGradient(
                          buttonText: "DONE",
                          press: () {

                          },
                          width: size.width * 9,
                        ),
                      ),
                    ),
                  ],



                ),

              ),





            ),







          ],
        ),
      ),

    );
  }
}

getSizedBox({double width, double height}) {
  return SizedBox(
    height: height,
    width: width,
  );
}



