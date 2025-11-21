import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/controller/db_service.dart';
import 'package:mobile/models/product_model.dart';
import 'package:shimmer/shimmer.dart';

class Zonecontainer extends StatefulWidget {
  final String category;
  const Zonecontainer({super.key, required this.category});
  
  @override
  State<Zonecontainer> createState() => _ZonecontainerState();
}

class _ZonecontainerState extends State<Zonecontainer> {
  Widget specialQuota({required int price, required int dis}){
    int random = Random().nextInt(2);
    List<String> quotes = ['Starting at ₹ $price', "Get upto $dis% off"];
    return Text(
      quotes[random],
      style: TextStyle(color:Color.fromARGB(255,76,175,79)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: DbService().readProducts(widget.category),
      builder: (context, snapshot){
        print(snapshot.data);
        if(snapshot.hasError){
          return Text('Error ${snapshot.error}');
        }
        else if(snapshot.connectionState == ConnectionState.waiting){
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
        else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return const Center(
            child:Text("No Product Found")
          );
        }
        else{
          List<Product> products = snapshot.data!;
          return Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.symmetric(horizontal:10),
            color:Color.fromARGB(255,232,245,233),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal:8,vertical:4),
                  child: Row(
                    children: [
                      Text(
                        widget.category.substring(0,1).toUpperCase() + widget.category.substring(1),
                        style: TextStyle(
                          fontSize:20,
                          fontWeight: FontWeight.w500,
                        ),

                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, "/specific",arguments:{'name':widget.category});
                        },
                        child: Text(
                          "See all",
                          style:TextStyle(
                              color:Color.fromARGB(255,33, 149, 243),
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Wrap(
                  spacing: 4,
                  children: [
                    for(int  i = 0; i <(products.length >4?4:products.length); i++)
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          width: MediaQuery.sizeOf(context).width*0.43,
                          padding: EdgeInsets.all(8),
                          height: 180,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color:Color.fromARGB(255,224,224,224),

                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  products[i].image,
                                  height: 120,
                                ),
                              ),
                              Text(
                                products[i].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:TextStyle(
                                  fontSize:15, fontWeight: FontWeight.w500
                                ),
                              ),
                              specialQuota(
                                price:products[i].newPrice,
                                dis: int.parse(Constants().discountPercent(products[i].oldPrice,products[i].newPrice))
                              )

                            ],
                          ),
                        ),
                      )
                  ],
                )
              ],
            )
          );
        }
      },
    );
  }
}
