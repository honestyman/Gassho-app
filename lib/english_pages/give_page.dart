import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: EnGivePage(),
    ),
  );
}

class EnGivePage extends StatefulWidget {
  const EnGivePage({super.key});

  static const routeName = '/give';

  @override
  State<EnGivePage> createState() => _EnGivePageState();
}

class _EnGivePageState extends State<EnGivePage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController first = TextEditingController();
  TextEditingController second = TextEditingController();
  TextEditingController third = TextEditingController();
  
  void sendValue(){
    int result=0;
    bool flag=true;
    if(third.text!=""){
      result=int.parse(third.text);
    }
    if(second.text!=""){
      result=int.parse(second.text)*10+result;
      if(third.text!=""){
        result=int.parse(first.text)*100+result;
      }
    }
    if((first.text!="" && (second.text=="" && third.text=="")) || (first.text!="" && (second.text=="" || third.text==""))){
      flag=false;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('The input data is incorrect.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  if(result!=0 && flag==true){
        result=result*100;
       final String string='Would you like to donate $result yen to this temple?';
       showDialog(
      context: context,
      builder: (_) => Center(
              // Aligns the container to center
              child: Container(
            // A simplified version of dialog.
            width: 244,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromRGBO(43, 43, 55, 1),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Make a donation to this temple',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nato',
                      fontSize: 14,
                    ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 5, left:15, right: 15),
                  child: Text(
                    string,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Nato',
                        fontSize: 13,
                        letterSpacing: -1),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.white30, width: 0.5))),
                        child: TextButton(
                            onPressed: () {
                              // Navigator.of(content).pop(false);
                              Navigator.of(context, rootNavigator: true).pop(false);
                              showAlertDialog_2(context);
                            },
                            child: const Text(
                              'OK',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(95, 134, 222, 1),
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.white30, width: 0.5))),
                        child: TextButton(
                            onPressed: () {
                              // Navigator.of(content).pop(false);
                              Navigator.of(context, rootNavigator: true).pop(false);
                            },
                            child: const Text(
                              'CANCEL',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(95, 134, 222, 1),
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/give_back.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: const EdgeInsets.only(
            left: 18,
            right: 18,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 62),
                height: 40,
                child: Container(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(138, 86, 172, 0.5),
                      foregroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        icon: const ImageIcon(
                            AssetImage("assets/images/cancel.png")),
                      ),
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 297.8),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Make a donation to this temple',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nato',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 17.5, bottom: 21.6),
                      child: ImageIcon(
                        AssetImage("assets/images/flower.png"),
                        color: Color.fromRGBO(138, 86, 172, 1),
                      ),
                    ),
                    Text(
                      'With gratitude, you can make a donation to Kongosanmai-in, special head temple of the Koyasan Shingon Sect',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nato',
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '（The amount donated will be net of any transaction fees and related expenses）',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nato',
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 32, bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 37,
                      height: 50,
                      child: TextFormField(
                        controller: first,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            // floatingLabelBehavior: FloatingLabelBehavior.always,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    SizedBox(
                      width: 37,
                      height: 50,
                      child: TextFormField(
                        controller: second,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            // floatingLabelBehavior: FloatingLabelBehavior.always,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    SizedBox(
                      width: 37,
                      height: 50,
                      child: TextFormField(
                        controller: third,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            // floatingLabelBehavior: FloatingLabelBehavior.always,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    const Text(
                      '00円',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nato',
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 11),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 354,
                height: 47,
                child: ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamed('/home');
                      sendValue();
                      // showAlertDialog_1(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(138, 86, 172, 1),
                    ),
                    child: const Text(
                      'Make a donation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nato ',
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


showAlertDialog_2(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => Center(
              // Aligns the container to center
              child: Container(
            // A simplified version of dialog.
            width: 244,
            height: 111,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromRGBO(43, 43, 55, 1),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Donated correctly!',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nato',
                        fontSize: 14,
                        letterSpacing: -1),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 244,
                    margin: const EdgeInsets.only(top: 15),
                    decoration: const BoxDecoration(
                        border: Border(
                            top:
                                BorderSide(color: Colors.white30, width: 0.5))),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop(false);
                          Navigator.of(context).pushNamed('/');
                        },
                        child: const Text(
                          'OK',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(95, 134, 222, 1),
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                )
              ],
            ),
          )));
}
