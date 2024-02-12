import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/english_pages/questionnaire_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/pages/requesturl.dart' as requesturl;


void main() {
  runApp(
    const MaterialApp(
      home: EnPlanPage(),
    ),
  );
}

class EnPlanPage extends StatelessWidget{
  const EnPlanPage({super.key});
  
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/back.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: PlanList(
          plans: [
            Plan(name_1: 'Monthly plan', name_2: '980円', name_3: ''),
            Plan(name_1: 'Annual plan', name_2: '9,800円', name_3: '11,760円'),
          ],
          ),
     ),
    );
  }
}

class TitleSection extends StatelessWidget{
  const TitleSection({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 70.5, left: 25, right: 25),
          child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20 ,
                  fontFamily: 'Lato'
                ),
          )
        ),
        const Padding(
          padding: EdgeInsets.only(top: 23.5, left:25, right: 25),
          child: Text(
                'Extensive resources for meditation, \nmindfulness, relaxation, and sleep',
                textAlign: TextAlign.center,
                style: TextStyle( 
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Lato'
                ),
          )
        ),
      ],
    );
  }
}

class Plan {
  const Plan({required this.name_1, required this.name_2, required this.name_3});

  final String name_1;
  final String name_2;
  final String name_3;
}

typedef CartChangedCallback = Function(String plan, bool inChecked);

class PlanListItem extends StatelessWidget {
  PlanListItem({
    required this.plan,
    required this.inChecked,
    required this.onCartChanged,
  }) : super(key: ObjectKey(plan));

  final Plan plan;
  final bool inChecked;
  final CartChangedCallback onCartChanged;

  Color _getbackColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inChecked //
        ? Colors.yellow.shade700
        : Colors.white60;
  }
  
  Border? _getBorder(BuildContext context) {
    if (!inChecked) return null;

    return  Border.all(
      width: 2,
      color:Colors.yellow.shade700
      // color: Colors.black54,
      // decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
       onPressed: () {
         onCartChanged(plan.name_1,inChecked);
       },
      child: Container(
        height: 66,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border:_getBorder(context),
            // border:Border.all(
            //   width: 2,
            //   color: Colors.yellow.shade700
            // ),
           color: Colors.white.withOpacity(0.5)
        ),
        margin: const EdgeInsets.only(
          left: 18,
          top: 8,
          bottom: 8,
          right: 18,
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20.3),
                child: Text(
                  plan.name_1,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
              )
            ),
            Container(
                margin: const EdgeInsets.only(right: 16),
                child: Text(
                  plan.name_3,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.white,
                    decorationStyle: TextDecorationStyle.solid
                     
                  ),
                  softWrap: true,
                )
              ),
            Container(
                margin: const EdgeInsets.only(right: 10),
                child: Text(
                  plan.name_2,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1
                  ),
                  softWrap: true,
                )
              ),
            
            Padding(
              padding: const EdgeInsets.only(right:13),
              child:  CircleAvatar(
                radius: 10,
                foregroundColor: Colors.white,
                backgroundColor: _getbackColor(context),
                child: const Icon(
                  Icons.check,
                  size: 15,
                  ),
              ),
              ),  
          ],
        ),
        
      )
    );
  }
}

class PlanList extends StatefulWidget {
  const PlanList({required this.plans, super.key});

  final List<Plan> plans;

  // The framework calls createState the first time
  // a widget appears at a given location in the tree.
  // If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework re-uses
  // the State object instead of creating a new State object.

  @override
  State<PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
    final List<String> _shoppingCart = [];

  Future<void> addPlan() async {
    const url="${requesturl.Constants.url}/api/users/plan";
    const storage = FlutterSecureStorage();
    String? email=await storage.read(key: 'email');
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': jsonEncode(email),
        'plan': jsonEncode(_shoppingCart),
      }),
    );
    if (response.statusCode == 200) { 
      // ignore: use_build_context_synchronously
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  showAlertDialog_1(BuildContext context) {
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
                'Completed.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  fontSize:14 ,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top:5),
              child: Text(
                'Your subscription is complete.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Lato',
                  fontSize:13 
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
                    addPlan();
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
            )
          ],
        ),
        )
      )
 );
}

  void _handleCartChanged(String plan, bool inChecked) {
    setState(() {
      // When a user changes what's in the cart, you need
      // to change _shoppingCart inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.
      var len=_shoppingCart.length;
      if (!inChecked) {
        if(len==0){
          _shoppingCart.add(plan);
        }else{
          _shoppingCart.clear();
          _shoppingCart.add(plan);
        }
      } else {
        _shoppingCart.remove(plan);
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return ListView(
      // backgroundColor: Colors.transparent, 
      children: [
        const TitleSection(name: 'Unrestricted, complimentary \naccess for 7 days'),
        Container(
          margin: const EdgeInsets.only(
            left: 22,
            top: 20,
            bottom: 20,
            right: 18,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(145, 107, 186, 1),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: const ImageIcon(
                        AssetImage("assets/images/image_icon1.png"),
                        // color:Color.fromRGBO(196, 174, 216, 1),
                        color: Colors.white60,
                      ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 23,
                      top: 0,
                      bottom: 0,
                      right: 0,
                    ),
                    padding: const EdgeInsets.only(right: 25),
                    child: const Text(
                      'Supervised and produced by the chief \npriest and monks of Kongosanmai-in, \na special temple of the Koyasan Shingon \nSect',
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ) 
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 19),
                child: Row(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      margin: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(69, 174, 160, 1),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: const ImageIcon(
                          AssetImage("assets/images/image_icon2.png"),
                          color: Colors.white60,
                        ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 23,
                        top: 0,
                        bottom: 0,
                        right: 0,
                      ),
                      child: const Text(
                        'Kongosanmai-in was established at the \nrequest of Hojo Masako, wife of \nMinamoto no Yoritomo, to mourn his \nspiritual legacy. In 2004, it was registered\nas a World Heritage site along with \nKoyasan Kongobu-ji, making it a temple \nof historical significance',
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ) 
                  ],
                ),
              ),
              
            ],
          ),
        
        ),
        Column(
         children: widget.plans.map((plan){
          return PlanListItem(
            plan: plan,
            inChecked: _shoppingCart.contains(plan.name_1),
            onCartChanged: _handleCartChanged,
          );
        }).toList(), 
        ),

        const Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Text(
                'After you subscribe to a plan, you have unlimited and complimentary access for 7 days. \nAfter this period is over, your payment will start, but until your payment starts you can cancel your subscription.',
                textAlign: TextAlign.center,
                style: TextStyle( 
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 12,
                  // letterSpacing: -2,
                  fontFamily: 'Lato'
                ),
          )
        ),
        Container(
          height: 47,
          margin: const EdgeInsets.only(
            left: 20,
            top: 21,
            bottom: 82,
            right: 20,
          ),
          child: ElevatedButton(
            onPressed:() {
               showAlertDialog_1(context);
            },
           style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(138, 86, 172, 1),
            ),
            child: const Text(
              'Subscribe',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato'
              ),
            )
            ),
        )
        
      ],
    );

  }
}

// showAlertDialog_1(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (_) => Center( // Aligns the container to center
//       child: Container( // A simplified version of dialog. 
//         width: 244,
//         height: 111,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           color: const Color.fromRGBO(43, 43, 55, 1),
//         ),
//         child: Column(
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(top:15),
//               child: Text(
//                 '完了しました。',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Lato',
//                   fontSize:14 ,
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(top:5),
//               child: Text(
//                 '申し込みが完了しました。',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: 'Lato',
//                   fontSize:13 ,
//                   letterSpacing: -1
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 width: 244,
//                 margin: const EdgeInsets.only(top: 15),
//                 decoration: const BoxDecoration(
//                   border:Border(
//                     top: BorderSide(
//                       color: Colors.white30,
//                       width: 0.5
//                     )
//                   )
//                 ),
//                 child: TextButton(
//                   onPressed: (){
//                     addPlan();
//                     Navigator.of(context, rootNavigator: true).pop(false);
//                      showAlertDialog_2(context);
//                   },
//                   child: const Text(
//                     'OK',
//                     textAlign: TextAlign.center,
//                      style: TextStyle(
//                        color: Color.fromRGBO(95, 134, 222, 1),
//                        fontWeight: FontWeight.bold
//                      ),
//                   )
//                 ),
//               ),
//             )
//           ],
//         ),
//         )
//       )
//  );
// }

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
              padding: EdgeInsets.only(top:15),
              child: Text(
                'Thank you!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  fontSize:14
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top:5),
              child: Text(
                'Please enjoy "GASSHO"',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Lato',
                  fontSize:13 
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
                  onPressed: (){},
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.of(context, rootNavigator: true).pop(false);
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const EnQuestionnairesApp())
                      );
                      },
                      child: Image.asset("assets/images/hands.png"),
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