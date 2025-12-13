import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/provider/StoreProvider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Categorycontainer extends StatefulWidget {
  const Categorycontainer({super.key});

  @override
  State<Categorycontainer> createState() => _CategorycontainerState();
}

class _CategorycontainerState extends State<Categorycontainer> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal, 
        itemCount: Constants().categories.length,
        itemBuilder: (context, index){
          final cat =Constants().categories[index];
          final isloadding = Provider.of<Storeprovider>(context, listen: false).isLoading;
          if(isloadding){
            return Shimmer.fromColors(
              baseColor:const Color.fromARGB(255, 200, 200, 200),
              highlightColor: const Color.fromARGB(255, 255, 255, 255),

              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color:Colors.grey[300],
                ),
              ),
            );
          }

          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/specific', arguments:{"name":cat["argument"]});
            },
              child:Container(
              margin: EdgeInsets.all(4), 
              padding: EdgeInsets.all(4), 
              height: 95, 
              width: 95, 
              decoration: BoxDecoration(
               color:Color.fromARGB(255,238,238,238), 
               borderRadius:BorderRadius.circular(20),
              ), 
              child: Column(
               mainAxisAlignment: MainAxisAlignment.center,  
               crossAxisAlignment: CrossAxisAlignment.center, 
               children: [
                 Image.asset(
                   cat["image"]!,
                   height: 50,
              ), 
               const SizedBox(height:8,),  
               Text(
                  "${cat['label']}"
               )
               ],
              ),
              ), 
          );
        },
      ), 
    );
  }
}
