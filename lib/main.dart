import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/components/no-internet.dart';
import 'package:mobile/controller/auth_service.dart';
import 'package:mobile/models/medicalmodel.dart';
import 'package:mobile/pages/Category.dart';
import 'package:mobile/pages/Chatbot.dart';
import 'package:mobile/pages/Login.dart';
import 'package:mobile/pages/Page_selection.dart';
import 'package:mobile/pages/UpdateProfile.dart';
import 'package:mobile/pages/signup.dart';
import 'package:mobile/pages/viewProduct.dart';
import 'package:mobile/provider/CartProvider.dart';
import 'package:mobile/provider/StoreProvider.dart';
import 'package:mobile/provider/UserProvider.dart';
import 'package:mobile/provider/UserpetProvider.dart';
import 'package:mobile/provider/feedbackProvider.dart';
import 'package:mobile/provider/internetConnectionprovider.dart';
import 'package:mobile/provider/medicalprovider.dart';
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
        ChangeNotifierProvider(create: (_)=> Internetconnectionprovider()),
        ChangeNotifierProvider(create:(context)=>Storeprovider()),
        ChangeNotifierProvider(create:(_)=>Userpetprovider()),
        ChangeNotifierProvider(create: (_)=>Medicalprovider()),
        ChangeNotifierProvider(create: (_)=>Cartprovider()),
        ChangeNotifierProvider(create: (_)=>Feedbackprovider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Flutter Demo',
        theme: ThemeData(fontFamily: "Poppins"),
       routes: {
          '/':(context)=>CheckUser(),
         '/page_selection':(context)=>PageSelection(defaultPage: 2),
          '/login':(context)=>Login(),
          "/signup":(context)=>SignUp(),
          '/specific':(context)=>Category(),
         '/view_product':(context)=>Viewproduct(),
         "/chatbot":(context)=>Chatbot(),
         "/update-profile":(context)=>Updateprofile(),
         "/from_anyWare_to_cart":(context)=>PageSelection(defaultPage: 0),
          "/from_anywhere_to_store":(context)=>PageSelection(defaultPage: 1),

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
      await Provider.of<Cartprovider>(context, listen: false).readCartdaTa();
      await Provider.of<Userpetprovider>(context,listen: false).fetchUserPets();
      await _waitForpetsLoad();
      await Provider.of<Medicalprovider>(context, listen: false).intializeMedicals(context);
      await Provider.of<Feedbackprovider>(context, listen: false).fetchFeedbacks();

      Navigator.pushNamed(context, '/page_selection');
    }else{
      Navigator.pushNamed(context, '/login');
    }
  }
  Future<void>_waitForpetsLoad()async{
    await Future.doWhile(()async{
      if(Provider.of<Userpetprovider>(context,listen:false ).isLoading){
        await Future.delayed(Duration(milliseconds:201 ));
        return true;
      }
      return false;
    });
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



