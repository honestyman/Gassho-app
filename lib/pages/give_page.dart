
import 'package:flutter/material.dart';


void main() {
  runApp(
    const MaterialApp(
      home: GivePage(),
    ),
  );
}

class GivePage extends StatefulWidget{
  const GivePage({super.key});
  
  static const routeName='/give';

  @override
  State<GivePage> createState() => _GivePageState();
}

class _GivePageState extends State<GivePage> {
  @override
  Widget build(BuildContext context){

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
                margin: const EdgeInsets.only(top:62),
                height: 40,
                child: 
                    Container(
                      alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          backgroundColor: const Color.fromRGBO(138, 86, 172, 0.5),
                          foregroundColor: Colors.white,
                          child: IconButton(
                            onPressed: (){
                              Navigator.of(context).pushNamed('/');
                            },
                             icon: const ImageIcon(
                              AssetImage("assets/images/cancel.png")
                             ),
                            ),
                        )
                      ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 297.8),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'このお寺にご志納をする',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Noto Sans JP',
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:17.5, bottom: 21.6),
                      child: ImageIcon(
                      AssetImage("assets/images/flower.png"),
                      color: Color.fromRGBO(138, 86, 172, 1),
                    ),
                    ),
                    Text(
                      '感謝の気持ちをこめて\n高野山真言宗 別格本山 金剛三昧院に\nお志を納められます',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Noto Sans JP',
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    Text(
                      '（決済手数料などの諸経費を差し引いた金額が納められます。）',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Noto Sans JP',
                        fontSize: 11,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top:32, bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 37,
                      height: 50,
                      child: TextFormField(
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
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5)
                                )
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    SizedBox(
                      width: 37,
                      height: 50,
                      child: TextFormField(
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
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5)
                                )
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    SizedBox(
                      width: 37,
                      height: 50,
                      child: TextFormField(
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
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5)
                                )
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    const Text(
                      '00円',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Noto Sans JP',
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 11
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                        width: 354,
                        height: 47,
                        child: ElevatedButton(
                          onPressed:() {
                            // Navigator.of(context).pushNamed('/home');
                            showAlertDialog_1(context);
                          },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(138, 86, 172, 1),
                        ),
                        child: const Text(
                            'ご志納をする',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Noto Sans JP ',
                            ),
                          )
                        ),
                ),

          ],
          ),
        ),
     ),
    );
  }
}

showAlertDialog_1(BuildContext context){
  showDialog(
    context: context,
    builder: (_) => Center( // Aligns the container to center
      child: Container( // A simplified version of dialog. 
        width: 244,
        height: 111,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromRGBO(43, 43, 55, 1),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top:15),
              child: Text(
                'このお寺にご志納をする',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Noto Sans CJK JP',
                  fontSize:14 ,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top:5),
              child: Text(
                'このお寺に〇〇円をお布施しますか？',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Noto Sans CJK JP',
                  fontSize:13 ,
                  letterSpacing: -1
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    decoration: const BoxDecoration(
                      border:Border(
                        top: BorderSide(
                          color: Colors.white30,
                          width: 0.5
                        )
                      )
                    ),
                    child: TextButton(
                      onPressed: (){
                        // Navigator.of(content).pop(false);
                        Navigator.of(context, rootNavigator: true).pop(false);
                        showAlertDialog_2(context);
                      },
                      child: const Text(
                        'OK',
                        textAlign: TextAlign.center,
                         style: TextStyle(
                           color: Color.fromRGBO(95, 134, 222, 1),
                           fontWeight: FontWeight.bold
                         ),
                      )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    decoration: const BoxDecoration(
                      border:Border(
                        top: BorderSide(
                          color: Colors.white30,
                          width: 0.5
                        )
                      )
                    ),
                    child: TextButton(
                      onPressed: (){
                        // Navigator.of(content).pop(false);
                        Navigator.of(context, rootNavigator: true).pop(false);
                      },
                      child: const Text(
                        'CANCEL',
                        textAlign: TextAlign.center,
                         style: TextStyle(
                           color: Color.fromRGBO(95, 134, 222, 1),
                           fontWeight: FontWeight.bold
                         ),
                      )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        )
      )
 );
}

showAlertDialog_2(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Center( // Aligns the container to center
      child: Container( // A simplified version of dialog. 
        width: 244,
        height: 111,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromRGBO(43, 43, 55, 1),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top:20),
              child: Text(
                '正確に献金しました！',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Noto Sans CJK JP',
                  fontSize:14 ,
                  letterSpacing: -1
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 244,
                margin: const EdgeInsets.only(top: 15),
                decoration: const BoxDecoration(
                  border:Border(
                    top: BorderSide(
                      color: Colors.white30,
                      width: 0.5
                    )
                  )
                ),
                child: TextButton(    
                      onPressed: (){
                        Navigator.of(context, rootNavigator: true).pop(false);
                        Navigator.of(context).pushNamed('/');
                      },
                      child: const Text(
                        'OK',
                        textAlign: TextAlign.center,
                         style: TextStyle(
                           color: Color.fromRGBO(95, 134, 222, 1),
                           fontWeight: FontWeight.bold
                         ),
                      )
                   
                ),
              ),
            )
          ],
        ),
        )
      )
 );
}