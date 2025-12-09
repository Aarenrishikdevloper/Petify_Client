import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/components/CartWidget.dart';
import 'package:mobile/components/Greetings.dart';
import 'package:mobile/components/MedicalContainer.dart';
import 'package:mobile/components/PromoContainer.dart';
import 'package:mobile/components/userPetContainer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xffeeedf2),
      body:SafeArea(
        child:SingleChildScrollView(
          physics: BouncingScrollPhysics(),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:10,),
               Greetings(),
              const SizedBox(height: 25,),
              const UserPetcontainer(),
              const SizedBox(height:25 ,),
              Medicalcontainer(defineHeight: 260, defineWeight:250),
              const SizedBox(height:10),
              Padding(
                padding: EdgeInsets.only(left:20, top:10, bottom:10),  
                child: Row(
                  children: [
                    const Icon(Icons.storefront_outlined, color:Color.fromARGB(255,92,81,245)), 
                    SizedBox(width: 10,), 
                    Text(
                      "Check The Store",  
                      style: TextStyle(
                        color:Colors.black, 
                        fontSize: 18,  
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
              ), 
             Padding(
               padding:EdgeInsets.only(left:10, right:10),
               child: SizedBox(
                 height: 150,
                 child: ListView(
                   scrollDirection: Axis.horizontal,
                   children: [
                     SizedBox(
                       height: 150,
                       width: 250,
                       child: Promocontainer(routetottheStore: true),
                     ),
                     SizedBox(width:10),
                     SizedBox(
                       width: 250,
                       child: Cartwidget(),
                     )
                   ],
                 ),
               ),
             ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left:10, right:10),
                height: 175,
                child:ListView(
                  scrollDirection: Axis.horizontal,  
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/chatbot');
                          },
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color:Color.fromARGB(255,193,127,231).withOpacity(0.4), 
                              borderRadius: BorderRadius.circular(20), 
                              
                            ),
                            child: Row(
                              children: [
                                Lottie.asset(
                                  "assets/animations/mr_bot.json"
                                ), 
                                Padding(
                                  padding: EdgeInsets.only(right:10), 
                                  child: Text(
                                     "Ask Anything !! \n mr.BOT is here",
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ), 
                        SizedBox(width:10,),  
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, "/from_anywhere_to_store");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20), 
                              color: Color.fromARGB(255,155,253,146).withOpacity(0.5),
                            ),
                            height: 160,
                            child:Row(
                              children: [
                                Lottie.asset("assets/animations/shop_now.json"),  
                                Padding(
                                  padding: EdgeInsets.only(right:10, ),
                                  child:Text("Get  Crazy Discounts \n Shop now!", textAlign:TextAlign.center,)
                                )
                              ],
                            )
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,)
                  ],
                )
              )
            ],
          ),
        )
      )
    );
  }
}
