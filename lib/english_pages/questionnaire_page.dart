import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/english_pages/home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    const MaterialApp(
      home: EnQuestionnairesApp(),
    ),
  );
}

class EnQuestionnairesApp extends StatelessWidget {
  const EnQuestionnairesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuestionnarePage(),
    );
  }
}

class Question {
  const Question({required this.text});

  final String text;
}

class QuestionnarePage extends StatefulWidget {
  const QuestionnarePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionnarePageState createState() => _QuestionnarePageState();
}

class _QuestionnarePageState extends State<QuestionnarePage> {
//Applying get request.
  final List<String> _shoppingCart = [];

  void writeIntroductionStorage() async{
    const storage = FlutterSecureStorage();
    storage.write(key: 'introductions', value: jsonEncode(_shoppingCart));
    String? reasons=await storage.read(key: 'reasons');
    String? introductions=await storage.read(key: 'introductions');
    String? email=await storage.read(key: 'email');
    await storage.delete(key: 'reasons');
    await storage.delete(key: 'introductions');
    
    if(reasons!=null && introductions!=null){
          List<dynamic> listReasons=jsonDecode(reasons);
          List<dynamic> listIntroductions=jsonDecode(introductions);

      // ignore: unused_local_variable
          final reasonData= await http.post(Uri.parse('http://localhost:5000/api/reasons/user_reasons/add'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': email.toString(),
              'reasons': jsonEncode(listReasons),
              'introductions': jsonEncode(listIntroductions),         
            })
          );
       }  
  }

  Future<List<Question>> getRequest() async {
    //replace your restFull API here.
    String url = "http://localhost:5000/api/introductions/";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<Question> questionnares = [];
    for (var singleQuestion in responseData) {
      Question question = Question(text: singleQuestion["en_text"]);

      //Adding question to the list.
      questionnares.add(question);
    }
    return questionnares;
  }

  void _handleCartChanged(String text, bool inChecked) {
    setState(() {
      // When a user changes what's in the cart, you need
      // to change _shoppingCart inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      if (!inChecked) {
        _shoppingCart.add(text);
      } else {
        _shoppingCart.remove(text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        // title: Text("Http Get Request."),
        // leading: Icon(
        // 	Icons.get_app,
        // ),
        // ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/back.png"),
                  fit: BoxFit.cover)),
          // padding: EdgeInsets.all(16.0),
          child: Expanded(
            child: Column(
              children: [
                const TitleSection(name: 'Where did you learn about "GASSHO"?'),
                Flexible(
                  child: FutureBuilder(
                    future: getRequest(),
                    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (ctx, index) => QuestionListItem(
                                  text: snapshot.data[index].text,
                                  inChecked: _shoppingCart
                                      .contains(snapshot.data[index].text),
                                  onCartChanged: _handleCartChanged,
                                ));
                      }
                    },
                  ),
                ),
                Container(
                  height: 47,
                  width: 354,
                  margin: const EdgeInsets.only(
                    left: 20,
                    top: 20,
                    bottom: 82,
                    right: 20,
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed("/register");
                        writeIntroductionStorage();
                        Navigator.push(context,MaterialPageRoute(builder: (context) => const EnHomeApp()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(138, 86, 172, 1),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato'),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef CartChangedCallback = Function(String text, bool inChecked);

class QuestionListItem extends StatelessWidget {
  const QuestionListItem(
      {required this.text,
      required this.inChecked,
      required this.onCartChanged,
      super.key});

  final String text;
  final bool inChecked;
  final CartChangedCallback onCartChanged;

  Color _getbackColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inChecked //
        ? Colors.yellow.shade700
        : Colors.transparent;
  }

  Color _getforeColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inChecked //
        ? Colors.white
        : Colors.transparent;
  }

  Border? _getBorder(BuildContext context) {
    if (!inChecked) return null;

    return Border.all(width: 2, color: Colors.yellow.shade700
        // color: Colors.black54,
        // decoration: TextDecoration.lineThrough,
        );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {
          onCartChanged(text, inChecked);
        },
        child: Container(
          height: 51,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: _getBorder(context),
              // border:Border.all(
              //   width: 2,
              //   color: Colors.yellow.shade700
              // ),
              color: Colors.white.withOpacity(0.5)),
          margin: const EdgeInsets.only(
            left: 18,
            top: 8,
            bottom: 8,
            right: 18,
          ),
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                    ),
                  softWrap: true,
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(right: 13),
                child: CircleAvatar(
                  radius: 10,
                  foregroundColor: _getforeColor(context),
                  backgroundColor: _getbackColor(context),
                  child: const Icon(
                    Icons.check,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 93.5, 0, 38),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Lato'),
      ),
    );
  }
}
