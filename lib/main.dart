import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mobile/components/no-internet.dart';
import 'package:mobile/controller/auth_service.dart';
import 'package:mobile/pages/Login.dart';
import 'package:mobile/pages/signup.dart';
import 'package:mobile/provider/UserProvider.dart';
import 'package:mobile/provider/internetConnectionprovider.dart';
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
        ChangeNotifierProvider(create: (_)=> Internetconnectionprovider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Flutter Demo',
        theme: ThemeData(fontFamily: "Poppins"),
       routes: {
          '/':(context)=>CheckUser(),
         '/page_selection':(context)=>Text("hello world"),
          '/login':(context)=>Login(),
          "/signup":(context)=>SignUp(),
       },


      ),
    );
  }
}
class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    _checkUserAndLoadData();
    // TODO: implement initState
    super.initState();
  }
  Future<void>_checkUserAndLoadData()async{
    var user = await AuthService().getCurrentUser();
    print(user);
    if(user != null){
      String userId = user['user_id'];
      Navigator.pushNamed(context, '/page_selection');
    }else{
      Navigator.pushNamed(context, '/login');
    }
  }
  @override
  Widget build(BuildContext context){
    final isConnectedToInternet = Provider.of<Internetconnectionprovider>(context).isConnectToInternet;
    return  !isConnectedToInternet?const NoInternet():Scaffold(
       backgroundColor: const Color(0xFFeeedf2),
       body:Center(
         child:CircularProgressIndicator(
           color:Colors.red,
         )
       )
    );
  }
}



