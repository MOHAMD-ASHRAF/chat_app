import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:store_app/features/presentation/pages/home_page.dart';
import 'package:store_app/features/presentation/pages/login_page.dart';
import 'package:store_app/features/presentation/pages/register_page.dart';
import 'package:store_app/firebase_options.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id : (context)=> const LoginPage(),
        RegisterPage.id : (context)=> const RegisterPage(),
        HomePage.id : (context)=>  HomePage(),
      },
      //onGenerateRoute: OnGenerateRoute.route,
    );
  }
}