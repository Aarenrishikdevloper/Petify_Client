import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/models/userPetModel.dart';
import 'package:mobile/provider/UserpetProvider.dart';
import 'package:provider/provider.dart';



class UserPetcontainer extends StatefulWidget {
  const UserPetcontainer({super.key});

  @override
  State<UserPetcontainer> createState() => _UserPetcontainerState();
}

class _UserPetcontainerState extends State<UserPetcontainer> {
  @override
  Widget build(BuildContext context) {
    return  Consumer<Userpetprovider>(
       builder: (context,userPetsProvider, child){
         if(userPetsProvider.isLoading){
           return const Center(child: CircularProgressIndicator(),);
         }else{
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(
                 padding: EdgeInsets.only(left:20),
                 child: const Text(
                    "Your Pets 🐕",
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),

                 ),
               ),
               const SizedBox(height: 10,),
               Padding(
                 padding: EdgeInsets.only(left: 20, right:10),
                 child: SizedBox(
                   height: 100,
                   child: ListView.separated(
                     separatorBuilder: (context,index)=>SizedBox(width: 23,),
                     itemCount: userPetsProvider.userPets.isEmpty ? 1:userPetsProvider.userPets.length + 1,
                     scrollDirection: Axis.horizontal,
                     physics: BouncingScrollPhysics(),
                     itemBuilder: (context, index){
                       if(userPetsProvider.userPets.isEmpty || index == 0){
                         return GestureDetector(
                            onTap: (){
                              _showAddOrUpdatePetDialog();
                            },
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color:Color(0xffc58Bf2).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(70)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 30,
                                    color:Colors.blue
                                  ),
                                  Text(
                                    "Add Pets"
                                  ),
                                ],
                              ),
                            ),
                         );
                       }else{
                         int petIndex = index - 1;
                         String modelpic =  "";
                         if(userPetsProvider.userPets[petIndex].species == "Dog"){
                           modelpic = "assets/images/user_pet_model_default_dog.png";
                         }else if(userPetsProvider.userPets[petIndex].species == "Cat"){
                           modelpic = "assets/images/user_pet_model_default_cat.png";
                         }else if(userPetsProvider.userPets[petIndex].species == "Bird"){
                           modelpic = "assets/images/pet_bird_default.png";
                         }
                         return GestureDetector(
                           onTap: (){
                             _showAddOrUpdatePetDialog(pet:userPetsProvider.userPets[petIndex]);
                           },
                           child: Container(
                             width: 100,
                             decoration: BoxDecoration(
                               color:Color(0xff92A3FD).withOpacity(0.4),
                               borderRadius: BorderRadius.circular(16)
                             ),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                         image: AssetImage(modelpic),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle
                                    ),
                                 ),
                                 Padding(
                                   padding: EdgeInsets.symmetric(horizontal:5),
                                   child: Text(
                                     userPetsProvider.userPets[petIndex].name,
                                     style:TextStyle(
                                       overflow:TextOverflow.ellipsis,
                                       fontSize: 14,
                                       fontWeight: FontWeight.w400,
                                       color:Color.fromARGB(255,0,0,0)
                                     )
                                   ),
                                 )
                               ],
                             ),
                           ),
                         );
                       }

                     },
                   ),
                 ),
               )
             ],
           );
         }
       },
    );
  } 
  void _showAddOrUpdatePetDialog({UserPetsModel?pet}){
    final TextEditingController petnameComtroller = TextEditingController();
    final TextEditingController petBreedController = TextEditingController();
    final TextEditingController petAgeController = TextEditingController();
    String petGender = 'male';
    String petSpecies = "Dog";
    String? petnameerror;
    String ?petageerror;
    if(pet != null){
      petnameComtroller.text = pet.name;
      petSpecies = pet.species;
      petBreedController.text = pet.breed;
      petAgeController.text = pet.age.toString();
      petGender = pet.gender;
    }
    showDialog(
      context: context,  
      builder: (BuildContext context){
        return StatefulBuilder(
          builder: (context,setState){
            return AlertDialog(
              title:Text(pet == null ?"Add a New Pet":"Update Pet Details"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                       controller: petnameComtroller,
                       decoration: InputDecoration(
                         labelText: "Pet Name",
                         errorText: petnameerror
                       ),
                      maxLength: 10,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,

                    ),
                    Row(
                      children: [
                        Text(
                          "Species",
                          style: TextStyle(fontSize:18),
                        ),
                        SizedBox(width:18,),
                        DropdownButton<String>(
                          value: petSpecies,
                          onChanged: (String?newvalue){
                            setState((){
                              petSpecies = newvalue!;
                            });
                          },
                          items:const<String>["Dog","Cat","Bird"]
                          .map<DropdownMenuItem<String>>((String value){
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    TextField(
                      maxLength: 10,
                      controller: petBreedController,
                      decoration: InputDecoration(
                        labelText: "Pet Breed"
                      ),
                    ),
                    TextField(
                      controller: petAgeController,
                      decoration: InputDecoration(
                        labelText: 'Pet Age',
                        errorText: petageerror,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9]{1,2}$'),
                        )
                      ],
                    ), 
                    Row(
                      children: [
                        Text("Gender", style:TextStyle(fontSize:18) ,), 
                        const SizedBox(width: 18,),
                        DropdownButton<String>(
                          value: petGender == "male"?"Male":"Female",
                          onChanged: (String?newvalue){
                            setState((){
                              petGender = newvalue == "Male"?"male":"female";

                            });
                            print(petGender);
                          },
                          items:const<String>["Male", "Female"]
                              .map<DropdownMenuItem<String>>((String value){
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                        )


                      ],
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                if(pet != null)
                  TextButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                         builder: (context){
                          return AlertDialog(
                            title:Text("Confirm Delete"),
                            content: Text("Are you sure you want to delete this pet"),
                            actions: [
                              TextButton(
                                onPressed: (){
                                  Provider.of<Userpetprovider>(context, listen: false).delepet(pet.petId); 
                                  Navigator.pop(context); 
                                  Navigator.pop(context);
                                },
                                child: Text("Yes"),
                              ), 
                              TextButton(
                                onPressed:(){
                                  Navigator.of(context).pop();
                                } ,
                                child: Text("No"),
                              )
                            ],
                          );
                         }
                      );
                    },
                    child:const Text("Delete Pet")
                  ),
                TextButton(
                  onPressed: (){
                    String petname = petnameComtroller.text.trim();
                    String petbreed = petBreedController.text.trim();
                    String ageInput = petAgeController.text.trim();
                    int? petAge = int.tryParse(ageInput);
                    setState((){
                       petnameerror = petname.isEmpty? "Please Enter a pet name":"";
                       petageerror = petAge == null || petAge <= 0 ? "pleae Enter a pet age":"";

                    });
                    if(petname.isNotEmpty && petAge != null &&  petAge > 0) {
                      print(petAge);
                       final petdetails =UserPetsModel(
                         petId: DateTime.now().toString(),
                         owner: "owner",
                         name:petname,
                         species: petSpecies,
                         breed: petbreed,
                         age:petAge,
                         gender: petGender
                       );

                       if(pet == null){
                         Provider.of<Userpetprovider>(context, listen: false).addpet(petdetails);
                       }else{
                         Provider.of<Userpetprovider>(context, listen: false).updatePet(pet.petId, petdetails);
                       }
                       Navigator.pop(context);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Pleae fill the required field"),
                        )
                      );
                    }

                  },
                  child: Text(pet == null ?"Add Pet":"Update Pet"),
                )
              ],
            );
          }
        );
      }
    );
  }
}
