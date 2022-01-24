import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'package:translator/translator.dart';

import 'package:translatorapp/helper/constant.dart';
import 'package:translatorapp/model/app_local.dart';

import 'custom_widget/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateHomeScreen();
  }
}

class StateHomeScreen extends State<HomeScreen> {
  TextEditingController textController = TextEditingController();
  final translator = GoogleTranslator();
  Translation? translatedValue;

  String fromValue = "From";
  String toValue = "To";
  String fromCode = " ";
  String toCode = " ";
  String codeValueFrom=" ";
  String codeValueTo=" ";

  Map<String, String> langNameFrom = {
    "From": " ",
    "Afrikaans": "af",
    "Arabic": "ar",
    "Armenian": "hy",
    "English": "en",
    "French": "fr",
    "German": "de",
    "Greek": "el",
    "Hindi": "hi",
    "Indonesian": "id",
    "Italian": "it",
    "Kannada": "kn",
    "Russian": "ru",
    "Spanish": "es",
    "Turkish": "tr",
  };
  Map<String, String> langNameTo = {
    "To": " ",
    "Afrikaans": "af",
    "Arabic": "ar",
    "Armenian": "hy",
    "English": "en",
    "French": "fr",
    "German": "de",
    "Greek": "el",
    "Hindi": "hi",
    "Indonesian": "id",
    "Italian": "it",
    "Kannada": "kn",
    "Russian": "ru",
    "Spanish": "es",
    "Turkish": "tr",
  };

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: !Get.isDarkMode?  Colors.grey[200]:Colors.black38,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
         AppLocal.of(context).getTranslated("Translator App"),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor:Constant.purpleColor,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Card(
                child: ListView(
                 
                  children: [
                    Card(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, right: 15, left: 15),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                style: TextStyle(fontWeight: FontWeight.w500,
                                    color: !Get.isDarkMode? Colors.black:Colors.white,
                                fontSize: 18),

                                items: langNameFrom
                                    .map((lang, code) {
                                  return MapEntry(
                                    code,
                                    DropdownMenuItem<String>(
                                      value: lang,
                                      child: Text(AppLocal.of(context).getTranslated( '$lang')),
                                      onTap: (){
                                        setState(() {
                                          codeValueFrom = code ;
                                        });

                                      },
                                    ),
                                  );
                                })
                                    .values
                                    .toList(),

                                onChanged: (String? value) {
                                  setState(() {
                                    fromValue = value!;
                                  });
                                },
                                value: fromValue,
                              ),
                            ),
                            ),
                            Expanded(
                              flex: 1,
                              child:  IconButton(
                                onPressed: () {
                                  setState(() {

                                    var val1=toValue;
                                    var val2 =fromValue;
                                    if(fromValue!=val1){
                                      fromValue=val1;
                                    }
                                    if(toValue!=val2){
                                      toValue=val2;
                                    }


                                  });
                                },
                                icon: Icon(
                                  Icons.swap_horiz,
                                  color: Constant.purpleColor,
                                  size: 35,
                                )),),
                            Expanded(
                              flex: 2,
                              child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                style: TextStyle(fontWeight: FontWeight.w500,
                                    color: !Get.isDarkMode? Colors.black:Colors.white,
                                    fontSize: 18),

                                items: langNameTo
                                    .map((lang, code) {
                                  return MapEntry(
                                    code,
                                    DropdownMenuItem<String>(
                                      value: lang,

                                      ////
                                    //  child: Text("$lang"),
                                      child: Text(AppLocal.of(context).getTranslated( '$lang')),
                                      onTap: (){
                                        setState(() {
                                          codeValueTo= code ;

                                        });
                                      },
                                    ),


                                  );
                                })
                                    .values
                                    .toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    toValue = value!;
                                  });
                                },
                                value: toValue,
                              ),
                            ),),


                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(

                        height: MediaQuery.of(context).size.height / 4.5,
                        child: TextFormField(

                          maxLines: 40,
                          cursorColor: Constant.purpleColor,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.text,

                          style: TextStyle(

                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                              wordSpacing: 1.5
                          ),
                          decoration: InputDecoration.collapsed(
                            filled: true,
                            hintText:AppLocal.of(context).getTranslated( 'Enter your text..'),
                          ),
                          controller: textController,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      //width: MediaQuery.of(context).size.width/3,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(

                            child:Icon(Icons.send,size: 35,color: Constant.purpleColor,),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),

                            ),
                            onPressed: () {
                              setState(() async {
                                Translation result = await translator.translate(
                                    textController.text,
                                    from: codeValueFrom,
                                    to: codeValueTo,
                                );
                                setState(() {
                                  translatedValue = result;
                                });

                              });
                            },
                          ),
                          MaterialButton(

                            child:Icon(Icons.delete,size: 35,color: Constant.purpleColor,),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),

                            ),
                            onPressed: () {
                              setState(() {

                                textController.text = " ";
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                  //),
                  //),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: double.infinity,
                  width: double.infinity,
                  color: Constant.purpleColor,
                  child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (translatedValue == null) ? " " : translatedValue!.text,
                        style: TextStyle(fontSize: 22, color: Colors.white,fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Clipboard.setData(new ClipboardData(
                                  text: translatedValue!.text));
                            },
                            child: Icon(
                              Icons.copy,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                translatedValue = null;

                              });
                            },
                            child: Icon(
                              Icons.delete,size: 35,
                              color: Colors.white,

                            ),
                          ),


                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
