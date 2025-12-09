import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/provider/UserProvider.dart';
import 'package:provider/provider.dart';

class Updateprofile extends StatefulWidget {
  const Updateprofile({super.key});

  @override
  State<Updateprofile> createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  final formKey = GlobalKey<FormState>();  
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = Provider.of<Userprovider>(context, listen: false);
    _nameController.text = user.name;
    _emailController.text = user.email;
    _addressController.text = user.address;
    _phoneController.text = user.phone;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeeedf2),  
      appBar: AppBar(
        title: Text(
           "Update Profile", 
        ),
        scrolledUnderElevation: 0, 
        forceMaterialTransparency: false,
      ), 
      body: SingleChildScrollView(
        child: Form( 
          key:formKey, 
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 13),    
            child:Column(
              children: [
                Container(
                  child:Lottie.asset("assets/animations/CuttiePack_Note.json")
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Name",
                    border: OutlineInputBorder(),


                  ),
                  maxLength: 15,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  validator: (value)=>value!.isEmpty ? "Name can't be empty":null ,
                ),
                SizedBox(height: 15,),
                TextFormField(
                  readOnly: true,
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Email",
                    border: OutlineInputBorder(),


                  ),

                  validator: (value)=>value!.isEmpty ? "Email can't be empty":null ,
                ),
                SizedBox(height:15 ,),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: "Address",
                    hintText: "Address",
                    border: OutlineInputBorder(),


                  ),
                  maxLines: 3,
                  validator: (value)=>value!.isEmpty ? "Address can't be empty":null ,
                ),
                SizedBox(height:15 ,),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: "Phone",
                    hintText: "Phone",
                    border: OutlineInputBorder(),


                  ),
                  keyboardType: TextInputType.phone,

                  validator: (value)=>value!.isEmpty ? "Phone can't be empty":null ,
                ),
                SizedBox(height: 15,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,

                  child: ElevatedButton(
                    onPressed: ()async{

                       if(formKey.currentState!.validate()){
                         String newName= _nameController.text;
                         String newAddress = _addressController.text;
                         String newPhone = _phoneController.text;
                         try{
                            String result = await Provider.of<Userprovider>(context, listen: false).updateUser(newName, newAddress, newPhone);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                            if(result == "User Updated successfully"){
                              Navigator.pop(context);
                            }
                         }catch(e){
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text("Error updating profile: $e"))
                           );
                         }
                       }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      backgroundColor: Color.fromARGB(255,246,180,255).withOpacity(0.4),
                      foregroundColor: Colors.black,
                    ),
                    child:Text("Update Profile", style:TextStyle(fontSize:16),),
                  ),
                )
              ],
            )
          ),
          
        ),
      ),
    );
  }
}
