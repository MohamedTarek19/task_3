import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/dataCubit/cubit_app_status.dart';
import 'package:task_3/dataCubit/my_app_cubit.dart';
import 'package:task_3/view/login_screen.dart';
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
  runApp(BlocProvider<AppCubit>(
        create: (context)  =>  AppCubit()..getProductsList(),
       child: MyApp(),));
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
        primarySwatch: Colors.purple,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: user == null
          ? Login()
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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext context) {
                return Login();
              }), (value) => false);
            },
            child: Row(
              children: const [
                Center(
                    child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 20),
                )),
                Icon(Icons.logout),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, state) {
          if (state is onPorductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is onPorductSuccess|| (context.read<AppCubit>().products?.isEmpty ?? true)) {
              return screens[pageIndex];
          }
          else{
            return Container(
              child:Text("${state}"),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) {
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
    );
  }
}
