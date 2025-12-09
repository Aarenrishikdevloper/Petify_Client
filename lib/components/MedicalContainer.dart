import 'package:flutter/material.dart';
import 'package:mobile/models/medicalmodel.dart';
import 'package:mobile/provider/UserpetProvider.dart';
import 'package:mobile/provider/medicalprovider.dart';
import 'package:provider/provider.dart';

class Medicalcontainer extends StatefulWidget {
  final double defineHeight,defineWeight;
  const Medicalcontainer({super.key,  required this.defineHeight, required this.defineWeight});

  @override
  State<Medicalcontainer> createState() => _MedicalcontainerState();
}

class _MedicalcontainerState extends State<Medicalcontainer> {

  @override
  Widget build(BuildContext context) {
    final userPetProviser = Provider.of<Userpetprovider>(context);
    return userPetProviser.isLoading ? const Center(child: CircularProgressIndicator(),):userPetProviser.userPets.isEmpty ? const Center(child:Text("No Pets found"),):
        SingleChildScrollView(
          scrollDirection:Axis.horizontal,
          child: Row(
            children:userPetProviser.userPets.map((pet){
              return Padding(
                padding:EdgeInsets.symmetric(horizontal:10) ,
                child:Container(
                  height:widget.defineHeight ,
                  child: Container(
                     decoration: BoxDecoration(
                       color:Color(0xff92A3FD).withOpacity(0.25),
                       borderRadius: BorderRadius.circular(30),

                     ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:0, vertical:10 ),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              pet.name,
                              style:const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                              )
                            ), 
                            SizedBox(height:8,),  
                            Consumer<Medicalprovider>(
                              builder:(context,medicalprovider,child){
                                List<MedicalRecord>medicals = medicalprovider.medicals.where((medical)=>medical.petId == pet.petId).toList();
                                if(medicalprovider.isLoading){
                                  return Center(
                                    child:Padding(
                                      padding:EdgeInsets.only(top:20 ) ,
                                      child:Text("No medical records \n found yet", textAlign:TextAlign.center,)
                                    ) ,
                                  );
                                }
                                if(medicals.isEmpty){
                                  return Center(
                                    child:Padding(
                                        padding:EdgeInsets.only(top:20 ) ,
                                        child:Text("No medical \n records  avalaible", textAlign:TextAlign.center,)
                                    ) ,
                                  );
                                }
                                return Column(
                                  children: medicals.map((medical){
                                    return Padding(
                                      padding: EdgeInsets.symmetric(horizontal:8),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              width:widget.defineWeight ,
                                              child:ListTile(
                                                title:Text(
                                                  "${medical.medication}",
                                                  style: TextStyle(
                                                    fontSize: 15
                                                  ),
                                                ) ,
                                                subtitle: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,

                                                  children: [
                                                    Text(
                                                      "Date:${medical.date.toLocal().toString().split(' ')[0]}"
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Status: "
                                                        ),
                                                        Text(
                                                          "${medical.status}",
                                                          style: TextStyle(
                                                            color: medical.status=="Completed"? Color.fromARGB(255,73,54,244):Color.fromARGB(255,0,150,5)
                                                          ),
                                                        )

                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                      color:Color(0xffc58BF2)
                                                    )
                                                  ],
                                                ),
                                              ) ,
                                            ),
                                            SizedBox(height: 10,)
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              } ,
                            )
                          ],
                        ) ,

                      ),
                    ),
                  ),
                ) ,
              );
            }).toList(),
          ),
        );
  }
}
