import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/components/defaultSearchbar.dart';
import 'package:mobile/pages/ProfilePage.dart';
import 'package:mobile/provider/UserProvider.dart';
import 'package:mobile/styles/app_styles.dart';
import 'package:provider/provider.dart';

class Greetings extends StatelessWidget {
  const Greetings({super.key});

  @override
  Widget build(BuildContext context) {
    final int currentHour = DateTime.now().hour;
    String greetingmessage;
    if(currentHour < 12){
       greetingmessage = "Good Morning";
    }else if(currentHour < 17){
      greetingmessage = "Good Afternoon";
    }else{
      greetingmessage = "Good Evening";
    }
    return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left:20),
            child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       greetingmessage, style: AppStyles.headlineStyle3,
                     ),
                     const SizedBox(height: 5,), 
                     Consumer<Userprovider>(
                       builder:(context,value,child)=>Text(value.name, style:AppStyles.headlineStyle1,) ,
                     )
                   ],
                 ), 
                 GestureDetector(
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profilepage()));
                   },
                   child: Lottie.asset('assets/animations/male_profile_lottie.json',height:135, fit:BoxFit.cover),
                 )
               ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:20),
            child: const Defaultsearchbar(),
          )
        ],
    );
  }
}

