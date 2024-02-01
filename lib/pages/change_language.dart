import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ChangeLanguage(),
    ),
  );
}

class ChangeLanguage extends StatefulWidget{
  const ChangeLanguage({super.key});
  static const routeName = '/change_language';
  
  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/settings_back.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: LanguageList(
          languages: [
            Language(name: '日本語'),
            Language(name: 'English'),
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
    return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:15),
            child:  IconButton(
              onPressed: (){
                Navigator.of(context).pushNamed('/setting');
              },
              icon: const ImageIcon(
                AssetImage("assets/images/before_arrow.png"),
                color: Colors.white,
              )
            ) 
          ),  
          Expanded(
            child: Text(
                name,
                textAlign:TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Noto Sans CJK JP',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1
                  ),
                  softWrap: true,
                ),
          ),
          const SizedBox(
            width: 50,
          )
        ],
      );
  }
}

class Language {
  const Language({required this.name});

  final String name;
}

typedef CartChangedCallback = Function(String language, bool inChecked);

class LanguageListItem extends StatelessWidget {
  LanguageListItem({
    required this.language,
    required this.inChecked,
    required this.onCartChanged,
  }) : super(key: ObjectKey(language));

  final Language language;
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
         onCartChanged(language.name,inChecked);
       },
      child: Container(
        height: 51,
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
                  language.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Noto Sans CJK JP',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  softWrap: true,
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(right:13),
              child:  CircleAvatar(
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
        
      )
    );
  }
}

class LanguageList extends StatefulWidget {
  const LanguageList({required this.languages, super.key});

  final List<Language> languages;

  // The framework calls createState the first time
  // a widget appears at a given location in the tree.
  // If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework re-uses
  // the State object instead of creating a new State object.

  @override
  State<LanguageList> createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
    final List<String> _shoppingCart = [];
    void saveLanguage() async{
       const storage = FlutterSecureStorage();
      if(_shoppingCart.isNotEmpty){
       String? value=await storage.read(key: 'language');
       if(_shoppingCart[0].contains(value.toString())){
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('現在ご利用中です。'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
       }else{
          await storage.write(key: 'language', value: _shoppingCart[0]);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushNamed('/setting');
       }
      }else{
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('言語を選択してください。'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }

  void _handleCartChanged(String language, bool inChecked) {
    setState(() {
      // When a user changes what's in the cart, you need
      // to change _shoppingCart inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.
      var len=_shoppingCart.length;
      if (!inChecked) {
        if(len==0){
          _shoppingCart.add(language);
        }else{
          _shoppingCart.clear();
          _shoppingCart.add(language);
        }
      } else {
        _shoppingCart.remove(language);
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      // backgroundColor: Colors.transparent, 
      children: [
        const SizedBox(
          height: 63.5,
        ),
        const TitleSection(name: '言語の変更'),
        const SizedBox(
          height: 46.5,
        ),
        Expanded(
          child: ListView(
           children: widget.languages.map((language){
            return LanguageListItem(
              language: language,
              inChecked: _shoppingCart.contains(language.name),
              onCartChanged: _handleCartChanged,
            );
          }).toList(), 
          ),
        ),
        Container(
          height: 47,
          width: 354,
          transformAlignment:Alignment.topCenter ,
          margin: const EdgeInsets.only(
            left: 25,
            top: 21,
            bottom: 406,
            right: 25,
          ),
          child: ElevatedButton(
            onPressed:() {
              saveLanguage();
              //  showAlertDialog_1(context);
            },
           style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(138, 86, 172, 1),
            ),
            child: const Text(
              '変更',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Noto Sans JP'
              ),
            )
            ),
        ),
        Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height:75,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding:const EdgeInsets.fromLTRB(0, 7.4, 0, 20.5), 
                        child: Row(
                          children: [
                            SizedBox(
                              width: 97.5,
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/');
                                },
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.home,
                                      color: Colors.black45,
                                    ),
                                    Text(
                                      'ホーム',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Noto Sans CJK JP',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400
                                      ),
                                    )
                                  ]
                                  ),
                              ),
                            ),
                            SizedBox(
                              width: 97.5,
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/search');
                                },
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Colors.black45,
                                    ),
                                    Text(
                                      'さがす',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Noto Sans CJK JP',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400
                                      ),
                                    )
                                  ]
                                  ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 97.5,
                                child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/mypage'); 
                                },
                                child: const Column(
                                  children: [
                                    ImageIcon(
                                      AssetImage("assets/images/mypage.png"),
                                      // color:Color.fromRGBO(196, 174, 216, 1),
                                      color: Colors.black45,
                                    ),
                                    Text(
                                      'マイページ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Noto Sans CJK JP',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400
                                      ),
                                    )
                                  ]
                                  ),
                              ), 
                              )
                              ),
                            SizedBox(
                              width: 97.5,
                              child: MaterialButton(
                                onPressed: () {
                                  
                                },
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.settings_rounded,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      '設定',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Noto Sans CJK JP',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400
                                      ),
                                    )
                                  ]
                                  ),
                              ),
                            )
                          ],
                        ),
                        ),
                    ),
                  ],
                )        
      ],
    );

  }
}
