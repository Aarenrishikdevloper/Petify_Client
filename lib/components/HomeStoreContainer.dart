import 'package:flutter/material.dart';
import 'package:mobile/components/BannerContainer.dart';
import 'package:mobile/components/ZoneContainer.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/models/promomodel.dart';
import 'package:mobile/provider/StoreProvider.dart';
import 'package:provider/provider.dart';

class Homestorecontainer extends StatefulWidget {
  const Homestorecontainer({super.key});

  @override
  State<Homestorecontainer> createState() => _HomestorecontainerState();
}

class _HomestorecontainerState extends State<Homestorecontainer> {
  int getMinLenght(int a , int b){
    return a < b ? a:b;
  }

  @override
  Widget build(BuildContext context) {
    print(Constants().categories[1]['argument']!);
    return Consumer<Storeprovider>(
      builder: (context,provider, child){
        List<PromoBannersModel>banners = provider.banners;
        int minlenght = getMinLenght(Constants().categories.length, banners.length );
        return Column(
            children:List.generate(minlenght, (i){
              return  Column(
                children: [
                  Zonecontainer(category:Constants().categories[i]['argument']!),
                  Bannercontainer(category: banners[i].category, image:banners[i].image)
                ],
              );
            })



        );
      },
    );
  }
}
