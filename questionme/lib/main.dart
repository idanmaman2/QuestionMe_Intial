import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:questionme/ContentPage/ContentScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:questionme/ProfilePageCreate.dart';
import 'package:questionme/authentication.dart';
import 'package:questionme/phone_auth_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

BuildContext? testContext;

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.unknown
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      color: Colors.blueAccent,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: ProfilePageDeisgn(),
    );
  }
}

class SiginUpPage extends StatefulWidget {
  SiginUpPage({Key? key}) : super(key: key);

  @override
  State<SiginUpPage> createState() => _SiginUpPageState();
}

class _SiginUpPageState extends State<SiginUpPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 4,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              FittedBox(
                child: Text("QuestionMe",
                    style: TextStyle(fontFamily: 'Title', fontSize: 30)),
                fit: BoxFit.fill,
              ),
            ]),
          ),
          Expanded(
              flex: 36,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(),
                    flex: 7,
                  ),
                  Expanded(
                    child: const Text(
                      "SignUp via Google or Phone:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(),
                    flex: 7,
                  ),
                  Expanded(
                      flex: 2,
                      child: SignInButton(
                        Buttons.Google,
                        text: "Sign up with Google",
                        onPressed: () {
                          Authentication.signInWithGoogle(context: context)
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPage(
                                            title: "Main",
                                          ))));
                        },
                      )),
                  Expanded(
                    child: Container(),
                    flex: 4,
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 220),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.lightGreen),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                    ],
                                  )),
                              Expanded(
                                child: Container(),
                                flex: 1,
                              ),
                              Expanded(
                                  flex: 16,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                          fit: BoxFit.fill,
                                          child: Text(
                                            "Sign up with Phone",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  ))
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhoneSign()));
                          },
                        ),
                      )),
                  Expanded(
                    child: Container(),
                    flex: 16,
                  ),
                ],
              ))
        ],
      )),
    ]);
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);
  final List<Widget> screens = [Content(), Scaffold(), Scaffold()];
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _buildScreens() {
    return [
      Content(),
      Text("Add"),
      Text("DM"),
    ];
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(251, 99, 118, 0.95),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    "QuestionMe",
                    style: TextStyle(
                        fontFamily: 'Title', fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        ),
        body: PersistentTabView(
          context,
          navBarStyle: NavBarStyle.style15,
          decoration: NavBarDecoration(
              colorBehindNavBar: Colors.indigo,
              borderRadius: BorderRadius.circular(5.0)),
          popAllScreensOnTapOfSelectedTab: true,
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          screens: _buildScreens(),
          selectedTabScreenContext: (context) {
            testContext = context;
          },
          onWillPop: (context) async {
            await showDialog(
              context: context as BuildContext,
              useSafeArea: true,
              builder: (context) => Container(
                height: 50.0,
                width: 50.0,
                color: Colors.white,
                child: ElevatedButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
            return false;
          },
          items: [
            PersistentBottomNavBarItem(
              icon: Icon(Icons.feed_rounded),
              title: "Feed",
              activeColorPrimary: Colors.blue,
              inactiveColorPrimary: Colors.grey,
              inactiveColorSecondary: Colors.purple,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              title: "Add",
              activeColorPrimary: Colors.blue,
              inactiveColorPrimary: Colors.blue,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.home),
              title: "Home",
              activeColorPrimary: Colors.blue,
              inactiveColorPrimary: Colors.grey,
              inactiveColorSecondary: Colors.purple,
            ),
          ],
        ));
  }
}
