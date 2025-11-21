import 'package:flutter/material.dart';

class Bannercontainer extends StatelessWidget {
  final String image, category;
  const Bannercontainer({super.key, required this.category, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/specific", arguments:{'name':category});
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Image.network(
           image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
