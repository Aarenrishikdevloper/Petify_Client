import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/controller/auth_service.dart';
import 'package:mobile/pages/Pet_health_care.dart';
import 'package:mobile/pages/ProfilePage.dart';
import 'package:mobile/pages/feedback.dart';
import 'package:mobile/provider/CartProvider.dart';
import 'package:mobile/provider/UserProvider.dart';
import 'package:mobile/provider/UserpetProvider.dart';
import 'package:mobile/provider/medicalprovider.dart';
import 'package:provider/provider.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =  AnimationController(vsync: this)
    ..duration = Duration(milliseconds:9000)
    ..repeat(reverse:false);
    _animationController.addListener((){});

  }
  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeeedf2),
      body:SafeArea(
        child:SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Lottie.asset(
                         'assets/animations/more_lottie_in_more.json',
                         height: 70,
                         fit:BoxFit.cover,
                         controller: _animationController,
                         repeat: false,
                         animate: true,
                         frameRate: FrameRate(60)


                      ),

                    ),
                    Text("More",
                      style:TextStyle(
                         fontSize: 38,
                         fontWeight: FontWeight.bold,
                         color:Color(0xFF3b3b3b)
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title:Row(
                  children: [
                    Container(
                      child:Lottie.asset(
                        'assets/animations/easter_profile.json',
                        height: 110,
                        fit: BoxFit.fitHeight,
                        controller: _animationController,
                        repeat: true,
                        animate: true,
                        frameRate: FrameRate(60)
                      ),

                    ),
                    SizedBox(width:15),
                    Text("Profile & Account Settings"),
                  ],

                ) ,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Profilepage()) );
                },
              ),
              Divider(),
              SizedBox(height:10),
              Divider(),
              ListTile(
                title: Row(
                  children: [
                    Lottie.asset(
                       'assets/animations/health_lottie_for_homepage.json',
                        height:55,
                        fit:BoxFit.contain,
                        repeat: true,
                        animate: true,
                        frameRate: FrameRate(60),
                    ),
                    SizedBox(width:15,),
                    Text("Pet Health & medical Tracker"),
                  ],

                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>PetHealthCare()));
                },
              ),
              Divider(),
              ListTile(
                title:Container(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(
                         FluentSystemIcons.ic_fluent_chat_filled,
                         color: Color.fromARGB(255,196,131,250),
                       ),
                       SizedBox(width:10),
                       Text("Ask from Mr Bot Petify")
                     ],
                   ),
                ),
                subtitle: Container(
                  child: Lottie.asset("assets/animations/mr_bot.json",
                      height: 200,
                      fit:BoxFit.fitHeight,
                      controller: _animationController,
                      repeat: true,
                      animate: true,
                      frameRate: FrameRate(60)
                  ),

                ),
                onTap: (){
                  Navigator.pushNamed(context, "/chatbot");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.notifications,
                  color:Color.fromARGB(255,131,250,137),

                ),
                title: Text("Notifications & Alerts"),
                subtitle: Text("Medicals will reload"),
                trailing: Switch(
                  value: true,
                  onChanged: (value){},
                ),

              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.feedback,
                  color:Color.fromARGB(255,250,131, 131),

                ),
                title: Text("Give Feedback"),
                subtitle: Text("Share your thought with us"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackPage()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title:Text("Log Out"),
                subtitle: Text("Sign out of your account"),
                onTap:()async{
                  Provider.of<Userprovider>(context, listen:false).cancelProvider();
                  Provider.of<Userpetprovider>(context, listen:false).cancelProvider();
                  Provider.of<Medicalprovider>(context, listen:false).cancelProvider();
                  Provider.of<Cartprovider>(context, listen:false).cancelProvider();
                  await AuthService().logout();
                  Navigator.pushNamedAndRemoveUntil(context, "/login", (route)=>false);





                } ,
              )

            ],
          )
        )
      )
    );
  }
}

