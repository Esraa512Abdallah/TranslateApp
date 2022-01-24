
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translatorapp/helper/constant.dart';
import 'package:translatorapp/model/app_local.dart';

import 'animated_toggle_lang.dart';
import 'animated_toggle_theme.dart';


class CustomDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateCustomDrawer();
  }

}
class StateCustomDrawer extends State<CustomDrawer>{

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Drawer(
      child: Container(

        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child:
                Icon(Icons.translate ,color: Colors.purple.shade800,size: 70,),
                //color: const Color(0xFF0A3157)
              ),
            ),
            Divider(
              // height: 20 ,
              color: Colors.black,
            ),
            Container(

              child: Column(
                children: [
                  Container(

                    child: Text(AppLocal.of(context).getTranslated("App Language"),
                      style: TextStyle(
                          fontSize: 25,
                          color: Constant.purpleColor,
                          fontWeight: FontWeight.w800),
                    ),
                    padding: EdgeInsets.only(top: 10,left: 15,right: 15,),
                    alignment: AlignmentDirectional.topStart,


                  ),

                  AnimatedToggleLang(
                    values: [AppLocal.of(context).getTranslated('English'),
                      AppLocal.of(context).getTranslated('Arabic')],
                    onToggleCallback: (value) {
                      setState(() {
                        // _toggleValue = value;
                      });
                    },
                    buttonColor:  Colors.purple.shade800,
                    backgroundColor: const Color(0xFFB5C1CC),
                    textColor: const Color(0xFFFFFFFF),


                  ),


                ],
              ),
            ),
            Divider(
              height: 50 ,
              color: Colors.black,
            ),
            Container(

              child: Column(
                children: [
                  Container(

                    child: Text(AppLocal.of(context).getTranslated("App Theme"),style: TextStyle(
                        fontSize: 25,
                        color: Constant.purpleColor,
                        fontWeight: FontWeight.w800),
                    ),
                    padding: EdgeInsets.only(top: 10,left: 15,right: 15,),
                    alignment: AlignmentDirectional.topStart,


                  ),

                  AnimatedToggleTheme(
                    values: [AppLocal.of(context).getTranslated('Light'),
                      AppLocal.of(context).getTranslated('Dark')],
                    onToggleCallback: (value) {
                      setState(() {

                      });
                    },
                    buttonColor: Colors.purple.shade800,
                    backgroundColor:  Color(0xFFB5C1CC),
                    textColor: Color(0xFFFFFFFF),

                  ),


                ],
              ),
            ),
            Divider(
              height: 50 ,
              color: Colors.black,
            ),



          ],
        ),
      ),
    );
  }
}