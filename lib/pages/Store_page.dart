import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mobile/components/CategoryContainer.dart';
import 'package:mobile/components/HomeStoreContainer.dart';
import 'package:mobile/components/defaultSearchbar.dart';
import 'package:mobile/components/PromoContainer.dart';
import 'package:mobile/components/no-internet.dart';
import 'package:mobile/provider/internetConnectionprovider.dart';
import 'package:mobile/styles/app_styles.dart';
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isConnectedToInternet = Provider.of<Internetconnectionprovider>(context).isConnectToInternet;
    return Scaffold(
      backgroundColor: Color(0xFFeeedf2),
      body:!isConnectedToInternet ?NoInternet():  SafeArea(
         child: SingleChildScrollView(
           child: Column(
             children: [
               Padding(
                 padding: EdgeInsets.all(10),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       "What are\n you looking for",
                       style: AppStyles.headlineStyle1.copyWith(fontSize:35),
                     ),
                     const SizedBox(height: 10,),
                     _buidCategoryButton(size),
                     const SizedBox(height:10,),
                     Defaultsearchbar(),
                     const SizedBox(height: 10,),
                     const Promocontainer(routetottheStore:false),
                     const Text(
                         "Categories 🐶",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize:24,

                          ),


                     ),
                   ],
                 ),
               ),
               Categorycontainer(),
               Homestorecontainer(),
             ],
           ),
         ),
      ),
    );
  }
  Widget _buidCategoryButton(Size size){
    final List<Map<String, String>> categories =[
      {'label':'Food', 'route':'/specific', 'argument':'cat food'},
      {'label':'Toys', 'route':'/specific', 'argument':'toys'},
      {'label':'Collar', 'route':'/specific', 'argument':'collar'},
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: categories.map((category){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 7),
          width: size.width * 0.25,
          decoration: BoxDecoration(
            color:Color.fromARGB(255, 246, 215, 255),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius:3,
                  blurRadius:5,
                  offset: Offset(0, 3)
              )
            ],

          ),
          child: Center(
            child: GestureDetector(
              onTap: ()=>Navigator.pushNamed(context, "/specific",arguments:{"name":category['argument']}),
              child: Text(category['label']!),
            ),
          ),
        );
      }).toList(),
    );
  }
}
