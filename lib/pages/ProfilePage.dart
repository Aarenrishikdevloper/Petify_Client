import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/provider/UserProvider.dart';
import 'package:provider/provider.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xFFeeedf2),
       appBar: AppBar(
         title: Text(
            "Profile",
           style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600
           ),
         ),
         scrolledUnderElevation: 0,
         forceMaterialTransparency: true,
       ),
      body:SingleChildScrollView(
         child: Column(
           children: [
             Container(
               child: Lottie.asset("assets/animations/male_profile_lottie.json",
                 height: 250, fit:BoxFit.contain
               ),
             ),
             Consumer<Userprovider>(
               builder: (context, value,child){
                  return Padding(
                    padding:EdgeInsets.symmetric(horizontal:20) ,
                    child:Card(
                      color: Color.fromARGB(255,246,100,255).withOpacity(0.4),
                      elevation: 8,
                      shadowColor:Colors.blueGrey.withOpacity(0.4) ,
                      child: ListTile(
                         title: Text(value.name),
                         subtitle: Text(value.email),
                        onTap: (){
                           Navigator.pushNamed(context, "/update-profile");
                        },
                        trailing: Icon(Icons.edit_outlined),
                      ),

                    ) ,
                  );

               },

             ),
             SizedBox(height:30,),
             Divider(),
             ListTile(
               title: Text("Orders"),
               leading: Icon(Icons.local_shipping_outlined, color:Color.fromARGB(255,131,139,250) ,),
               onTap:(){} ,

             ),
             Divider(
               thickness: 1,
               endIndent: 10,
               indent:10
             ),
             ListTile(
               title: Text("Help & Support"),
               leading: Icon(
                 Icons.support_agent,
                 color: Color.fromARGB(255,248,121,121),

               ),
               onTap: (){
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                      backgroundColor: Color.fromARGB(255,246,180,255).withOpacity(0.4),
                      duration: Duration(seconds: 10),
                     content: Text(
                        "For Help & Support Mail me \n @infinix@proton.com",
                       textAlign: .center,
                       style: TextStyle(
                          color:Colors.black
                       ),

                     ),
                   )
                 );
               },
             ),
             Divider(
                thickness: 1,
                endIndent: 10,
                indent: 10,
             ),
             ListTile(
               title: Text("Logout"),
               leading: Icon(Icons.logout_outlined),
             )

           ],
         ),

      )

    );
  }
}
