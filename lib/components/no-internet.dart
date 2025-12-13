import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({super.key});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {

  @override
  Widget build(BuildContext context) {
    double screenwith = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFeeedf2),
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child:Lottie.asset('assets/animations/no_internet.json', height:screenwith, fit:BoxFit.cover),

            ),
            Text(
              "No internet connection \n found 📶",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:Colors.black,
              ),

            )
          ],
        )
      )

    );
  }
}
