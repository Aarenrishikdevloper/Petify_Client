
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:mobile/controller/db_service.dart';

import '../models/product_model.dart';

class Defaultsearchbar extends StatefulWidget {
  const Defaultsearchbar({super.key});

  @override
  State<Defaultsearchbar> createState() => _DefaultsearchbarState();
}

class _DefaultsearchbarState extends State<Defaultsearchbar> {
  final TextEditingController _searchcontroller  = TextEditingController();
  List<Product> searchResults =[];

  final DbService dbservice = DbService();
  void _searchProducts(String query)async{
    if(query.isEmpty){
      setState(() {
        searchResults.clear();
      });
    }

    List<Product>result = await dbservice.searchProductBYName(query);
    setState(() {
      searchResults = result;
    });


  }
  void clearSearch(){
    _searchcontroller.clear();
    _searchProducts('');

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0x0ff1d617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0
          )
        ], 
        
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchcontroller,
            onChanged: _searchProducts,
            decoration: InputDecoration(
              filled: true,  
              fillColor: const Color.fromARGB(255,255,255,255), 
              contentPadding: EdgeInsets.all(15), 
              hintText: 'Search Products', 
              hintStyle: TextStyle(color:Color.fromARGB(255,139,137,137), fontSize:14), 
              prefixIcon: const Icon(FluentSystemIcons.ic_fluent_search_regular, color:Color(0xFFBFC285)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ), 
              suffixIcon: SizedBox(
                width: 100, 
                child: IntrinsicHeight(
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,  
                     children: [
                       const VerticalDivider(
                         color:Color.fromARGB(255,0,0,0), 
                         indent: 10,
                         endIndent: 12, 
                         thickness: 0.2,
                       ), 
                       GestureDetector(
                         onTap: clearSearch,
                         child: Padding(
                           padding: EdgeInsets.all(8), 
                           child: Icon(FluentSystemIcons.ic_fluent_clear_formatting_filled),
                         ),
                       )
                     ],
                  ),
                ),
              )
            ),
          ),
          if(searchResults.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.only(top:10),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchResults.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){},
                    child:Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical:8, horizontal:16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical:8,horizontal:10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child:Image.network(
                                searchResults[index].image,
                                width: 60,
                                height: 60,
                                fit:BoxFit.cover
                              )

                            ),
                            SizedBox(width:12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    searchResults[index].name,
                                    style: TextStyle(
                                      fontSize:14,
                                      fontWeight: FontWeight.bold,
                                      color:Colors.black87

                                    ),
                                  ),
                                  SizedBox(height:5,),
                                  Text(
                                    '\₹${searchResults[index].newPrice}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color:Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if(searchResults[index].oldPrice > 0)
                                    Text(
                                      '\₹${searchResults[index].newPrice}',
                                      style: TextStyle(
                                        fontSize:12,
                                        decoration:TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ) ,
                  );
                },
              ),
            )
          ]
        ],
      ),
    );
  }
}
