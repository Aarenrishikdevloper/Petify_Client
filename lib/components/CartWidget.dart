

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/provider/CartProvider.dart';
import 'package:provider/provider.dart';

class Cartwidget extends StatefulWidget {
  const Cartwidget({super.key});

  @override
  State<Cartwidget> createState() => _CartwidgetState();
}

class _CartwidgetState extends State<Cartwidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cartprovider>(
       builder:(context, value, child){
         if(value.isLoading){
            return const Center(
              child:CircularProgressIndicator(),
            );
         }
         else if(value.carts.isEmpty){
            return Center(child:Text("No Item in Cart"),);
         }
         else if(value.carts.isNotEmpty){
            return GestureDetector(
              onTap: (){
                Navigator.pushReplacementNamed(context, "/from_anyWare_to_cart");
              },
               child: Container(
                 decoration:BoxDecoration(
                   color:const Color.fromARGB(255,255,215,253),
                   borderRadius: BorderRadius.circular(8),
                   border:Border.all(
                      color:const Color.fromARGB(255,255,101,247)
                   )
                 ) ,
                 child:Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Lottie.asset(
                       "assets/animations/cart_lottie.json",
                       height: 145, fit: BoxFit.cover
                     ),
                     Padding(
                       padding: EdgeInsets.only(right:10),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("Your Cart", style:TextStyle(fontSize:19) ,),
                           SizedBox(height:10,) ,
                           Text("Items: ${value.carts.length}"),
                           SizedBox(height:4,),
                           Text("Total : ${value.totalCost}"),

                         ],
                       ),
                     )
                   ],
                 ) ,

               ),
            );
         }
         else{
           return Text("No item in cart");
         }
       },
    );
  }
}
