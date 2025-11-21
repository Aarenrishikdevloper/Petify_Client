import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';

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
                   cat['image']!,  
                   height: 50,
              ), 
               const SizedBox(height:8,),  
               Text(cat["label"]!)
               ],
              ),
              ), 
          );
        },
      ), 
    );
  }
}
