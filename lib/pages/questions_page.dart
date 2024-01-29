import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/register_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    const MaterialApp(
      home: QuestionsApp(),
    ),
  );
}

class QuestionsApp extends StatelessWidget {
  const QuestionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class Question {
  const Question({required this.text});

  final String text;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//Applying get request.
  final List<String> _shoppingCart = [];

  @override 
  void initState() { 
   getUser();
    super.initState(); 
  }

  void getUser() async{
    const storage = FlutterSecureStorage();
    // await storage.deleteAll();
    String? token=await storage.read(key: 'jwt');
    // String string=token.toString().trim();
    if(token!=null){
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => new HomeApp()));
    }
  }

  void writeStorage() {
    const storage = FlutterSecureStorage();
    storage.write(key: 'reasons', value: jsonEncode(_shoppingCart));
  }

  Future<List<Question>> getRequest() async {
    //replace your restFull API here.
    String url = "http://localhost:5000/api/reasons/";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<Question> questions = [];
    for (var singleQuestion in responseData) {
      Question question = Question(text: singleQuestion["text"]);

      //Adding question to the list.
      questions.add(question);
    }
    return questions;
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
                const TitleSection(name: '『合掌』を使う理由を教えてください'),
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
                        writeStorage();
                        // Navigator.of(context).pushNamed("/register");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                        // getReason();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(138, 86, 172, 1),
                      ),
                      child: const Text(
                        '続ける',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Noto Sans JP'),
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
                      fontFamily: 'Noto Sans CJK JP',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -1),
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
      padding: const EdgeInsets.fromLTRB(18, 93.5, 97, 38),
      child: Text(
        name,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
            letterSpacing: -2,
            fontFamily: 'Noto Sans CJK JP'),
      ),
    );
  }
}
