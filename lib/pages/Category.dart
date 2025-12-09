import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/controller/db_service.dart';
import 'package:mobile/models/product_model.dart';


class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
       backgroundColor: Color(0xFFeeedf2),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,
        title: Text("${args['name'].substring(0,1).toUpperCase()}${args['name'].substring(1)}")
      ),
      body:StreamBuilder<List<Product>>(
        stream:DbService().readProducts(args["name"]),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
             return const Center(
               child:CircularProgressIndicator(),
             );
          }
         else if(snapshot.hasError){
            return  Text('Error: ${snapshot.error}');
          }
          else if(snapshot.hasData){
            List<Product>products = snapshot.data!;
            if(products.isEmpty){
              Text("No produts found");
            }else{
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 15,
                ),
                itemCount: products.length,
                itemBuilder: (context,index){
                  final product = products[index];
                  return GestureDetector(
                    onTap: (){
                       Navigator.pushNamed(context, '/view_product', arguments:product);
                    },
                    child: Card(
                      color:const Color.fromARGB(255,224,224,224),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color:Color.fromARGB(255,224,224,224),
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(product.image),
                                    fit: BoxFit.fitHeight,
                                  )
                                ),
                              ),

                            ),
                            SizedBox(height: 8,),
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 2,),
                                Baseline(
                                  baseline: 18,
                                  baselineType: TextBaseline.alphabetic,
                                  child: Text(
                                     "₹ ${product.oldPrice}",
                                    style: TextStyle(
                                       fontSize: 13,
                                       fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 2,

                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:4,
                                ),
                                Text(
                                  "₹ ${product.newPrice}",
                                   style: TextStyle(
                                     fontWeight: FontWeight.w500,
                                     fontSize: 15
                                   ),
                                ),
                                SizedBox(width: 2,),
                                const Icon(
                                   Icons.arrow_downward,
                                  color:Color.fromARGB(255,76,175,79),
                                  size: 14,
                                ),
                                Text(
                                   "${Constants().discountPercent(product.oldPrice, product.newPrice)}%",
                                  style: TextStyle(
                                     fontSize:16,
                                    fontWeight:FontWeight.bold,
                                    color: Color.fromARGB(255,76,125,79)
                                  ),
                                )

                              ],
                            )

                          ],
                        ),
                      ),

                    ),
                  );
                },
              );
            }
          }
          return Text("No Product Found");

        },

      )

    );
  }
}
