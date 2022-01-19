import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';
import 'package:translatorapp/helper/constant.dart';

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
  Translation? TranslatedValue;


  String fromValue ="Translate from";
  String toValue ="Translate to";
  String fromCode = " ";
  String toCode = " ";

  Map<String,String> langNamefrom = {
    "Translate from":" ",
    "Afrikaans":"af",
    "Arabic":"ar",
    "Armenian":"hy",
    "Chinese":"zh",
    "English":"en",
    "French":"fr",
    "German":"de",
    "Greek":"el",
    "Hindi":"hi",
    "Indonesian":"id",
    "Italian":"it",
    "Kannada":"kn",
    "Russian":"ru",
    "Spanish":"es",
    "Turkish":"tr",
  };
  Map<String,String> langNameto = {
    "Translate to":" ",
    "Afrikaans":"af",
    "Arabic":"ar",
    "Armenian":"hy",
    "Chinese":"zh",
    "English":"en",
    "French":"fr",
    "German":"de",
    "Greek":"el",
    "Hindi":"hi",
    "Indonesian":"id",
    "Italian":"it",
    "Kannada":"kn",
    "Russian":"ru",
    "Spanish":"es",
    "Turkish":"tr",
  };



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Translator App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Constant.PinkColor,
      ),
      body: Container(
       child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Card(
                child: ListView(
                /*  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(*/
                      children: [
                        Card(
                            color: Constant.PinkColor,
                          child: Container(
                            padding: EdgeInsets.only(top: 5,bottom: 5,right: 10,left: 20),
                            child: Row(
                              children: [
                                DropdownButton<String>(
                                  // style: TextStyle(color: Colors.white),
                                  //  focusColor: Colors.white,
                                  items: langNamefrom.map(( lang , code) {
                                    return MapEntry(code,
                                      DropdownMenuItem<String>(
                                          value: lang,
                                          child: Text(lang)),);
                                  }).values.toList(),

                                  onChanged: (String? value){
                                    setState(() {
                                      fromValue = value! ;
                                    });
                                  },
                                  value: fromValue,
                                ),
                                IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.swap_horiz,color: Colors.white,size: 30,)),
                                DropdownButton(
                                  items: langNameto.map((lang , code) {
                                    return MapEntry(
                                      code,
                                      DropdownMenuItem<String>(
                                          value: lang,
                                          child: Text(lang)),);
                                  }).values.toList(),

                                  onChanged: (String? value){
                                    setState(() {
                                      toValue = value! ;

                                    });
                                  },
                                  value: toValue,
                                ),

                              ],

                            ),
                          ),
                        
                        ),
                        
                        
                        
                        Container(
                          padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                          height: MediaQuery.of(context).size.height / 8,

                          child: TextFormField(
                            maxLines: 15,
                            cursorColor: Constant.PinkColor,
                            textDirection: TextDirection.ltr,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                                wordSpacing: 1.5),
                            decoration: InputDecoration.collapsed(
                              filled: true,
                           //   fillColor: Constant.,
                              hintText: 'Enter your text..',
                            ),
                            controller: textController,
                          ),

                        ),
                        Container(
                          padding: EdgeInsets.only(top:10),
                          //width: MediaQuery.of(context).size.width/3,
                          width: 100,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(

                                child: Text("Translate",style: TextStyle(color: Colors.white),),
                                color: Constant.PinkColor,
                                onPressed: () {
                                  setState(() async {
                                    Translation result = await translator.translate(
                                        textController.text,
                                        from: 'en',
                                        to: 'ar');
                                    setState(() {
                                      TranslatedValue = result;
                                    });
                                    print("TranslatedValue result : $TranslatedValue");
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
                  height: double.infinity,
                  width: double.infinity,
                  color: Constant.PinkColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (TranslatedValue == null) ? " " : TranslatedValue!.text,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Clipboard.setData(new ClipboardData(
                                  text: TranslatedValue!.text));
                            },
                            child: Icon(
                              Icons.copy,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                TranslatedValue = null;
                                textController.text = " ";
                              });
                            },
                            child: Icon(
                              Icons.cancel_outlined,
                              color: Colors.white,
                              size: 30,
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
