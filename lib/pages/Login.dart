import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/controller/auth_service.dart';
import 'package:mobile/provider/UserProvider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController _emailController  = TextEditingController();
  final TextEditingController _passwordcontroler  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeeedf2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: 30,),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Lottie.asset('assets/animations/hellow_world.json',
                          width: MediaQuery.of(context).size.width / 1.25,
                          fit: BoxFit.fitWidth,
                        ),

                      ),
                      Text("Login", style: TextStyle(fontSize:30, fontWeight:FontWeight.w700),),
                      SizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        width:MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          validator: (value)=>value!.isEmpty?"Email can't be empty":null,
                          controller: _emailController,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            label: Text("Email"),
                          ),


                        ),

                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        width:MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          validator: (value)=>value!.length < 8 ?"Password should have at least 8 characters":null,
                          controller: _passwordcontroler,
                          obscureText: true,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            label: Text("Password"),
                          ),


                        ),

                      ),
                      SizedBox(height: 6,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed:(){},
                              child:Text("Forget Password",style: TextStyle(
                                color:Color.fromARGB(255,114,133,228)
                              ),
                              )
                          )
                        ],
                      ),



                    ],
                  ),
                ),
                SizedBox(height:10,),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * .9,
                  child: ElevatedButton(
                      onPressed:(){
                       if(formkey.currentState!.validate()){
                           AuthService().login(_emailController.text, _passwordcontroler.text).then((value)async{
                             if(value == "Login Successful"){
                               ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text("Login Sucessfully"))
                               );
                               await Provider.of<Userprovider>(context, listen: false).loadUser();
                             }else{
                               ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(content:Text(value, style:TextStyle(color:Colors.white),),backgroundColor:Colors.red.shade400,)
                               );
                             }
                           });
                       }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255,219,197,74).withOpacity(0.6),
                        foregroundColor: Colors.black,
                      ),
                      child: Text("Login", style: TextStyle(fontSize: 16),)
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(onPressed:(){
                      Navigator.pushNamed(context, "/signup");
                    }, child:Text("Sign Up"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}

