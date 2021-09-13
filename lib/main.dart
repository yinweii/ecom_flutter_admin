import 'package:ecom_admin/provider/authprovider.dart';
import 'package:ecom_admin/provider/orders.dart';
import 'package:ecom_admin/provider/products.dart';
import 'package:ecom_admin/screen/authscreen/login.dart';
import 'package:ecom_admin/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:min_id/min_id.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  MinId.withPattern('htp{2{d}}{1{w}}{3{w}}{1{d}}{3{w}}{3{w}}{d}{w}');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        StreamProvider<User>.value(
            value: AuthProvider().users, initialData: null)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrap(),
      ),
    );
  }
}

class Wrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      return Home();
    } else {
      return Login();
    }
  }
}
