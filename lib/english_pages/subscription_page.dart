
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: EnSubscriptionPage(),
    ),
  );
}

class EnSubscriptionPage extends StatelessWidget {
  const EnSubscriptionPage({super.key});
  static const routeName = '/en_subscription';

  @override
  Widget build(BuildContext context) {
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

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 63.5),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/en_setting');
                        },
                        icon: const ImageIcon(
                          AssetImage("assets/images/before_arrow.png"),
                          color: Colors.white,
                        ))),
                
                Expanded(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Nato'),
                  ),
                ),
                const SizedBox(
                  width: 50,
                )
              ],
            )),
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 49.5, left: 25, right: 14),
              child: Row(
                children: [
                  Text(
                    'Current Plan',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nato',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(
                    'Monthly plan（980円）',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nato',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ))
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 11, left: 25, right: 18),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    'Registered: Dec 3, 2023, 1:53 a.m',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nato',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 11, left: 25, right: 18),
              child: Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 80),
                padding: const EdgeInsets.only(right:10),
                color: Colors.red,
                child: const Text(
                  'Your access is complimentary until 11:59 p.m. on the day after 7 days of your registration',
                  textAlign: TextAlign.right,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nato',
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              )),
            ),
          ],
        )
      ],
    );
  }
}

class Plan {
  const Plan(
      {required this.name_1, required this.name_2, required this.name_3});

  final String name_1;
  final String name_2;
  final String name_3;
}

typedef CartChangedCallback = Function(Plan plan, bool inChecked);

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

    return Border.all(width: 2, color: Colors.yellow.shade700
        // color: Colors.black54,
        // decoration: TextDecoration.lineThrough,
        );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {
          onCartChanged(plan, inChecked);
        },
        child: Container(
          height: 66,
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
                  child: Container(
                margin: const EdgeInsets.only(left: 20.3),
                child: Text(
                  plan.name_1,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nato',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
              )),
              Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: Text(
                    plan.name_3,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nato',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.white,
                        decorationStyle: TextDecorationStyle.solid),
                    softWrap: true,
                  )),
              Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    plan.name_2,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nato',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -1),
                    softWrap: true,
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 13),
                child: CircleAvatar(
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
        ));
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
  final _shoppingCart = <Plan>{};

  void _handleCartChanged(Plan plan, bool inChecked) {
    setState(() {
      // When a user changes what's in the cart, you need
      // to change _shoppingCart inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.
      var len = _shoppingCart.length;
      if (!inChecked) {
        if (len == 0) {
          _shoppingCart.add(plan);
        } else {
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
        const TitleSection(name: 'Subscription'),
        Container(
          margin: const EdgeInsets.only(
            left: 22,
            bottom: 40,
            right: 18,
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [],
          ),
        ),
        Column(
          children: widget.plans.map((plan) {
            return PlanListItem(
              plan: plan,
              inChecked: _shoppingCart.contains(plan),
              onCartChanged: _handleCartChanged,
            );
          }).toList(),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20, left: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left:10, right: 30),
                  child: Text(
                    'When you switch to the annual plan, it will take effect the day after the end of your current monthly plan. ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Nato'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right:30),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: const TextSpan(
                        text: 'If you wish to cancel your subscription, please proceed with the cancellation process',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nato',
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                            ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'here',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline)),
                          // TextSpan(text: 'から手続きをお願い\nいたします。'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Container(
          height: 47,
          margin: const EdgeInsets.only(
            left: 18,
            top: 21,
            bottom: 82,
            right: 18,
          ),
          child: ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pushNamed("/register");
                showAlertDialog_1(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(138, 86, 172, 1),
              ),
              child: const Text(
                'プラン変更',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nato'),
              )),
        )
      ],
    );
  }
}

showAlertDialog_1(BuildContext context) {
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
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    '完了しました。',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nato',
                      fontSize: 14,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    '申し込みが完了しました。',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Nato',
                        fontSize: 13,
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
                          Navigator.pop(context, false);
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
                )
              ],
            ),
          )));
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
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'ありがとうございます！',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nato',
                        fontSize: 14,
                        letterSpacing: -1),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    '是非『合掌』をご利用ください',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Nato',
                        fontSize: 13,
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
                        onPressed: () {},
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/questionnaire');
                          },
                          child: Image.asset("assets/images/hands.png"),
                        )),
                  ),
                )
              ],
            ),
          )));
}
