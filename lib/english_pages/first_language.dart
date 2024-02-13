
import 'package:flutter/material.dart';
import 'package:flutter_app/english_pages/home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(
    const MaterialApp(
      home: EnFirstChangeLanguage(),
    ),
  );
}

class EnFirstChangeLanguage extends StatefulWidget{
  const EnFirstChangeLanguage({super.key});

  @override
  State<EnFirstChangeLanguage> createState() => _EnFirstChangeLanguageState();
}

class _EnFirstChangeLanguageState extends State<EnFirstChangeLanguage> {

   @override 
  void initState() { 
    getUser();
    super.initState(); 
  }

  void getUser() async{
    const storage = FlutterSecureStorage();
    String? token=await storage.read(key: 'jwt');
    if(token!=null){
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const EnHomeApp()));
    }
  }

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
        body: LanguageList(
          languages: [
            Language(name: 'Japanese'),
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 93.5),
          child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18 ,
                  fontFamily: 'Lato'
                ),
          )
        ),
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
                    fontFamily: 'Lato',
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
    void saveLanguage(){
      if(_shoppingCart.isNotEmpty){
       const storage = FlutterSecureStorage();
       storage.write(key: 'language', value: _shoppingCart[0]);
       if(_shoppingCart[0].toString()=="Japanese"){
        Navigator.of(context).pushNamed('/login');
       }else{
        Navigator.of(context).pushNamed('/en_login');
       }
      }else{
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Please select a language.'),
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
    return ListView(
      // backgroundColor: Colors.transparent, 
      children: [
        const TitleSection(name: 'Select your language'),
        const SizedBox(
          height: 46.5,
        ),
        Column(
         children: widget.languages.map((language){
          return LanguageListItem(
            language: language,
            inChecked: _shoppingCart.contains(language.name),
            onCartChanged: _handleCartChanged,
          );
        }).toList(), 
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
              saveLanguage();
              //  showAlertDialog_1(context);
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
//                   fontFamily: 'Noto Sans CJK JP',
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
//                   fontFamily: 'Noto Sans CJK JP',
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
//                     addLanguage();
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

