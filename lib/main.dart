import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/pages/Login.dart';
import 'package:mobile/pages/signup.dart';
import 'package:mobile/provider/UserProvider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Hide the status bar globally
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: const Color(0xFFeeedf2),
      statusBarIconBrightness: Brightness.dark,
    )
  );
  //turn of auth rotation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Userprovider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Flutter Demo',
        theme: ThemeData(fontFamily: "Poppins"),
       routes: {
          '/login':(context)=>Login(),
          "/signup":(context)=>SignUp(),
       },

        home: Login(),
      ),
    );
  }
}


