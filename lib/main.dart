import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/home/bloc/home_bloc.dart';
import 'package:todo/home/home_screen.dart';
import 'package:todo/login/bloc/login_bloc.dart';
import 'package:todo/login/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await check();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}
String rout="";

Future<void>check()async{
  SharedPreferences sharedPreference =await SharedPreferences.getInstance();
  rout= sharedPreference.getString('token')!=null ?'/':'/login';


}
class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //useMaterial3: true,
      ),
      initialRoute: rout,

      routes: {
        '/login':(context) => BlocProvider<LoginBloc>(create: (context)=>LoginBloc(),child:const LoginScreen(),),
        '/':(context)=>BlocProvider<HomeBloc>(create: (context)=>HomeBloc()..add(GetDataEvent()),child: const HomeScreen(),),
      },
    );
  }
}
