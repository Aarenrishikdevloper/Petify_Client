import 'package:flutter/material.dart';
import 'package:mobile/components/carContainer.dart';
import 'package:mobile/provider/CartProvider.dart';
import 'package:provider/provider.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeeedf2),
      appBar: AppBar(
        title:const Text("Your Cart", style:TextStyle(fontSize:22, fontWeight:FontWeight.w600),),
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<Cartprovider>(
         builder:(context,value,child){
           if(value.carts.isEmpty){
             return const Center(child:Text("No Items in cart"),);
           }else{
             if(value.carts.isNotEmpty){
                 return ListView.builder(
                    itemCount: value.carts.length,
                    itemBuilder: (context, index){
                      return Carcontainer(
                         image:value.carts[index].product.image,
                         name:value.carts[index].product.name,
                         new_price:value.carts[index].product.newPrice,
                         old_price:value.carts[index].product.oldPrice,
                         maxQuantity: value.carts[index].product.maxQuantity,
                         selectedQuantity: value.carts[index].quantity,
                         productId:value.carts[index].product.id,
                         id: value.carts[index].id,



                      );
                    },
                 );
             }else{
               return Center(
                 child: Text("No Item in Cart"),
               );
             }
           }
         }
      ),
      bottomNavigationBar: Consumer<Cartprovider>(
        builder: (context, value, child){
          if(value.carts.isEmpty){
            return SizedBox();
          }else{
             return Container(
               width: double.infinity,
               height: 60,
               padding: EdgeInsets.all(8),
               child:Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      "Total: ₹ ${value.totalCost}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),

                    ),
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255,13,64,105),
                        foregroundColor: Color.fromARGB(255,355,255,255)
                      ),
                      child: Text("Proceed to CheckOut"),
                    )
                  ],
               ) ,
             );
          }
        },
      ),
    );
  }
}
