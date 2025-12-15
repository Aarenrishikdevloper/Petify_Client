import 'package:flutter/material.dart';
import 'package:mobile/components/MedicalContainer.dart';
import 'package:mobile/provider/UserpetProvider.dart';
import 'package:provider/provider.dart';

class PetHealthCare extends StatefulWidget {
  const PetHealthCare({super.key});

  @override
  State<PetHealthCare> createState() => _PetHealthCareState();
}

class _PetHealthCareState extends State<PetHealthCare> {
  String petId ="";
  String name = "";
  String breed = "";
  int age = 0;
  String gender = "";
  String species = "";
  void _updatePetDetails(String newPetId, String newName,String newBreed, int newAge, String newGender, String newSpecies){
    setState(() {
      petId = newPetId;
      name = newName;
      breed = newBreed;
      age = newAge;
      gender = newGender;
      species = newSpecies;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(
          "Pet Heath & Wellness"
        ),
        backgroundColor: Color(0xFFeeedf2),
      ) ,
      backgroundColor: Color(0xFFeeedf2),
      body: SafeArea(
        child: Container(
           padding: EdgeInsets.all(8),
           child: SingleChildScrollView(
             child: Column(
               children: [
                 SizedBox(height: 5,),
                 UserPetContainerFroTracker( onpetselected: _updatePetDetails,),
                 SizedBox(height: 10,),
                 Column(
                   children: [
                      _buildinfoCart(),
                      SizedBox(height:5,),
                      Divider(),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left:20),
                            child: const Text(
                               "Medicals",
                               style: TextStyle(
                                 color:Colors.black,
                                 fontSize: 18,
                                 fontWeight: FontWeight.w600
                               ),
                            ),
                          ),
                          SizedBox(width:10,),
                          Icon(
                            Icons.medical_services,
                            color:Color.fromARGB(255,221,100,91)
                          )
                        ],
                      ),
                      SizedBox(height:10,),
                      Medicalcontainer(defineHeight: 500, defineWeight:250)
                   ],
                 )
               ],
             ),
           ),
        ),
      ),
    );
   
  } 
  Widget _buildinfoCart(){
    String modelPic;
    if(species == "Dog"){
      modelPic = "assets/images/user_pet_model_default_dog.png";
    }
    else if(species == "Cat"){
      modelPic = "assets/images/user_pet_model_default_cat.png";
    }else {
      modelPic = "assets/images/pet_bird_default.png";
    }
    return Card(
      color:Color(0xffc58BF2).withOpacity(0.4),  
      elevation: 8,  
      shadowColor: Colors.blueGrey.withOpacity(0.4), 
      child: ListTile(
        contentPadding: EdgeInsets.all(16),  
        title:Text(name == ""? "Select a pet to View" : "$name", style:TextStyle(fontSize:24, fontWeight:FontWeight.bold ),),  
        subtitle: Row(
          children: [
            Text("Age: $age years\nGender: $gender "),  
            SizedBox(width:15,),  
            Text('$species: $species\nBreed: $breed'),
          ]  
              
        ), 
        leading:CircleAvatar(
          radius: 30, 
          backgroundImage: AssetImage(modelPic),
        ) ,
      ),
    );
  }
}
class UserPetContainerFroTracker extends StatefulWidget {  
  final Function(String petId, String name, String breed, int age, String gender, String species) onpetselected;
   UserPetContainerFroTracker({super.key, required this.onpetselected}); 

  @override
  State<UserPetContainerFroTracker> createState() => _UserPetContainerFroTrackerState();
}

class _UserPetContainerFroTrackerState extends State<UserPetContainerFroTracker> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Userpetprovider>(
      builder:(context,userpetprovider,child){
        if(userpetprovider.isLoading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else{
          return Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: EdgeInsets.only(top:20),
                child: Text(
                  "your Pets",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              SizedBox(height: 5,),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  separatorBuilder: (context,index)=>SizedBox(width:25,),
                  itemCount:userpetprovider.userPets.isEmpty?1:userpetprovider.userPets.length ,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left:20, right: 20),
                  itemBuilder: (context,index){
                    if(userpetprovider.userPets.isEmpty){
                      return Center(child:Text("No Pets avalaible"),);
                    }else{
                      int petIndex = index;
                      String modelpic;
                      if(userpetprovider.userPets[petIndex].species == "Dog"){
                        modelpic = "assets/images/user_pet_model_default_dog.png";
                      }
                      else if(userpetprovider.userPets[index].species == "Cat"){
                        modelpic = "assets/images/user_pet_model_default_cat.png";
                      }else{
                        modelpic = "assets/images/pet_bird_default.png";
                      }
                      return GestureDetector( 
                        onTap: (){
                          widget.onpetselected(
                            userpetprovider.userPets[petIndex].petId,
                            userpetprovider.userPets[petIndex].name,
                            userpetprovider.userPets[petIndex].breed,
                            userpetprovider.userPets[petIndex].age,
                            userpetprovider.userPets[petIndex].gender,
                            userpetprovider.userPets[petIndex].species,

                          );
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xff92A3FD).withOpacity(0.4),
                             borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(
                            mainAxisAlignment: .spaceEvenly,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(modelpic),
                                    fit: BoxFit.cover,
                                  )
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                   userpetprovider.userPets[index].name,
                                   style: TextStyle(
                                     overflow: TextOverflow.ellipsis,
                                     fontSize: 14,
                                     fontWeight: FontWeight.w400,
                                     color: Color.fromARGB(255,0,0,0)
                                   ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          );
        }
      } ,
    );
  }
}


