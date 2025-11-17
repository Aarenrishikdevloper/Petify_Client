import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/controller/auth_service.dart';
import 'package:mobile/provider/UserProvider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController _namecontroller  = TextEditingController();
  final TextEditingController _emailController  = TextEditingController();
  final TextEditingController _passwordcontroler  = TextEditingController();
  final TextEditingController _confirmController  = TextEditingController();
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
                      Text("Sign Up", style: TextStyle(fontSize:30, fontWeight:FontWeight.w700),),
                      SizedBox(
                         height: 10,
                      ),
                      SizedBox(
                        width:MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          validator: (value)=>value!.isEmpty?"Name can't be empty":null,
                          controller: _namecontroller,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            label: Text("Name"),
                          ),
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,

                        ),

                      ),
                      SizedBox(height: 10,),
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
                      SizedBox(height: 10,),
                      SizedBox(
                        width:MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          validator: (value)=>value != _passwordcontroler.text ?"Password do not match":null,
                          controller: _confirmController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            label: Text("Confirm Password"),
                          ),


                        ),

                      ),



                    ],
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * .9,
                  child: ElevatedButton(
                      onPressed:(){
                        if(formkey.currentState!.validate()){
                          AuthService().createAccountWithEmail(_namecontroller.text, _emailController.text, _passwordcontroler.text, _confirmController.text).then((value){
                            if(value == "Account Created"){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Account Created")));
                             Provider.of<Userprovider>(context, listen:false).loadUser();
                              Navigator.restorablePushNamedAndRemoveUntil(context, "/", (route)=>false);
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
                      child: Text("Sign Up", style: TextStyle(fontSize: 16),)
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text("Already have an account?"),
                     TextButton(onPressed:(){
                       Navigator.pop(context);
                     }, child:Text("Login"))
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
