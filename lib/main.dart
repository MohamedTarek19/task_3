import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/dataCubit/auth_cubit.dart';
import 'package:task_3/dataCubit/cubit_app_status.dart';
import 'package:task_3/dataCubit/my_app_cubit.dart';
import 'package:task_3/dataCubit/profile_cubit.dart';
import 'package:task_3/view/login_screen.dart';
import 'package:task_3/view/new_login.dart';
import 'package:task_3/view/profile.dart';
import 'firebase_options.dart';
import 'package:task_3/helper.dart';
import 'package:task_3/view/first_screen.dart';
import 'package:task_3/view/second_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));
  runApp(BlocProvider<AuthCubit>(
  create: (context) => AuthCubit(),
  child: MyApp(),
));
}

class MyApp extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xff0e108d, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
          <int, Color>{
            50: Color(0xff0e1050 ),//10%
            100: Color(0xffb74c3a),//20%
            200: Color(0xffa04332),//30%
            300: Color(0xff89392b),//40%
            400: Color(0xff733024),//50%
            500: Color(0xff5c261d),//60%
            600: Color(0xff451c16),//70%
            700: Color(0xff2e130e),//80%
            800: Color(0xff170907),//90%
            900: Color(0xff000000),//100%
          }, ),
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: user == null
          ? NewLoginScreen()
          : MyHomePage(
              title: 'Home Page',
            ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;

  List<Widget> screens = [Home(), Screen2(), Profile()];

  PageChanger(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider<AppCubit>(
      create: (context) => AppCubit()..getProductsList(),
),
    BlocProvider<ProfileCubit>(
      create: (context) => (ProfileCubit()..GetData()),
    ),
  ],
  child: Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(pageIndex == 0?'Home': pageIndex == 1? 'Calculate':'Profile',style: TextStyle(color: Colors.black),),
        actions: [
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext context) {
                return NewLoginScreen();
              }), (value) => false);
            },
            child: Row(
              children: const [
                Center(
                    child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 20,color: Colors.black),
                )),
                Icon(Icons.logout,color: Colors.black,),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, state) {
          if (state is onPorductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is onPorductSuccess ||
              (context.read<AppCubit>().products?.isNotEmpty ?? true)) {
            return screens[pageIndex];
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height*0.1,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ], color: Colors.deepPurple[900],
            borderRadius: BorderRadius.circular(40)),
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: pageIndex,
          onTap: (index) {
            print(screens[pageIndex]);
            PageChanger(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calculate), label: 'Calculate'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    ),
);
  }
}
