import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:mobile/pages/CartPage.dart';
import 'package:mobile/pages/Home.dart';
import 'package:mobile/pages/More.dart';
import 'package:mobile/pages/Store_page.dart';

class PageSelection extends StatefulWidget {
  final int defaultPage;
  const PageSelection({super.key, required this.defaultPage});

  @override
  State<PageSelection> createState() => _PageSelectionState();
}

class _PageSelectionState extends State<PageSelection> {
  late int slectedPageIndex;
  @override
  void initState() {
    slectedPageIndex = widget.defaultPage;
    // TODO: implement initState
    super.initState();
  }
  void _pageSelection(int index){
    setState(() {
      slectedPageIndex = index;
    });
  }
  final applicationPages =[
     Cartpage(),
     StorePage(),
     Home(),
    Text("hello World"),
    More(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeeedf2),
      bottomNavigationBar: Container(


        decoration:BoxDecoration(
          color:Color(0xFFeeedf2),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 3
            )
          ]
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: slectedPageIndex,
          onTap: _pageSelection,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color.fromARGB(255, 121, 143, 255),
          unselectedItemColor: Colors.grey[600],
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon:Icon(FluentSystemIcons.ic_fluent_store_microsoft_filled),
              label: 'Cart'
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.store),
                label: 'Store'
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.home),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.delivery_dining_outlined),
                label: 'Lost & Find'
            ),
            BottomNavigationBarItem(
                icon:Icon(FluentSystemIcons.ic_fluent_more_filled),
                label: 'More'
            ),


          ],

        ),
      ),
      body: applicationPages[slectedPageIndex],
    );
  }
}
