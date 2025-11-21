
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile/provider/StoreProvider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Promocontainer extends StatefulWidget {
  final bool routetottheStore;
  const Promocontainer({super.key, required this.routetottheStore});

  @override
  State<Promocontainer> createState() => _PromocontainerState();
}

class _PromocontainerState extends State<Promocontainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Storeprovider>(
      builder:(context, shopprovider, child){
        if(shopprovider.isLoading){
          return  Shimmer.fromColors(
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
        if(shopprovider.promos.isEmpty && !shopprovider.isLoading){
          return const SizedBox();
        }
        return CarouselSlider(
           items:shopprovider.promos.map((promo){
              return GestureDetector(
                onTap: (){
                  if(!widget.routetottheStore){
                    Navigator.pushNamed(context, '/specific', arguments:{"name":promo.category});

                  }else{
                    Navigator.pushReplacementNamed(context, '/from_anywhere_to_store');
                  }
                },
                child:Image.network(
                   promo.image,
                  fit: BoxFit.cover,
                )
              );
           }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval:const Duration(seconds:5),
            aspectRatio:16/8,
            viewportFraction: 1.0,
            enlargeCenterPage:false,
            scrollDirection: Axis.horizontal
          ),
        );
      },
    );
  }
}
