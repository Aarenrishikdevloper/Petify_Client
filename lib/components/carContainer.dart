import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/provider/CartProvider.dart';
import 'package:provider/provider.dart';

class Carcontainer extends StatefulWidget {
  final String image, name, productId, id;
  final int new_price, old_price,maxQuantity, selectedQuantity;
  const Carcontainer({super.key, required this.name, required this.image , required this.productId, required  this.maxQuantity, required this.new_price, required this.old_price, required this.selectedQuantity, required this.id});

  @override
  State<Carcontainer> createState() => _CarcontainerState();
}

class _CarcontainerState extends State<Carcontainer> {
    late int count;
   @override
  void initState() {
     count = widget.selectedQuantity;
    // TODO: implement initState
    super.initState();
    print(widget.image);
  }
  increaseCount(int max)async{
     if(count >= max){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Maximun quality reached")));
       return ;
     }else{
        Provider.of<Cartprovider>(context, listen: false).addToCart(widget.productId, count);
        setState(() {
          count++;
        });
     }

  }
  decreasecoun(String cartId)async{
     if(count > 1){
       Provider.of<Cartprovider>(context, listen: false).decreaseQuantity(cartId);
       setState(() {
         count--;
       });
     }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding:EdgeInsets.all(8) ,
        child:Card(
           color:Color.fromARGB(255, 216,184, 241).withOpacity(0.4),
           elevation: 0,
           shadowColor:Colors.blueGrey.withOpacity(0.4),
          child: Container(
            width:double.infinity,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child:CachedNetworkImage(
                          imageUrl:widget.image,
                          fit: BoxFit.scaleDown,
                      ),
                    ), 
                    SizedBox(width:10), 
                    Expanded(
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child:Text(
                              widget.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:TextStyle(
                                fontSize:16,
                                fontWeight: FontWeight.w600
                              )
                            )
                          ),
                          SizedBox(height: 6,),
                          Row(
                            children: [
                              SizedBox(width:2,),
                              Text(
                                 "₹ ${widget.old_price}",
                                  style: TextStyle(
                                    fontSize:16,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 1
                                  ),

                              ),
                              SizedBox(width:8,),

                                Text(
                                  "₹ ${widget.new_price}",
                                  style: TextStyle(
                                     fontSize: 18, fontWeight: FontWeight.w600
                                  ),
                                ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.arrow_downward,
                                color:Color.fromARGB(255,26,156,31),
                                size: 30,
                              ),
                              Text(
                                "${Constants().discountPercent(widget.old_price, widget.new_price)}%",
                                style: TextStyle(
                                   fontSize:18,
                                   fontWeight: FontWeight.bold,
                                   color:Color.fromARGB(255,45,199,51),
                                ),
                              )

                            ],
                          )
                        ],
                      )
                    ),
                    IconButton(
                      onPressed: ()async{
                        Provider.of<Cartprovider>(context, listen:false).deleteItem(widget.id);
                      },
                      icon: Icon(
                         Icons.delete,
                         color:Color.fromARGB(255, 219,90,88)
                      ),
                    )
                  ],

                ),
                SizedBox(
                  height:16 ,

                ),
                Padding(
                  padding: const EdgeInsets.only(left:10, bottom:10),
                  child: Row(
                    children: [
                      Text(
                        "Quantity:",
                        style: TextStyle(fontSize: 16, fontWeight:FontWeight.w500 ),
                      ),  
                      SizedBox(
                        width: 8,
                      ), 
                      Container(
                        width: 40,  
                        height: 40,  
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), 
                          color:Color.fromARGB(255,161,157,218)
                        ),
                        child: IconButton(
                          onPressed:(){
                            increaseCount(widget.maxQuantity);
                          } ,
                          icon: Icon(Icons.add),
                        ),
                      ),
                      SizedBox(width:8,),
                      Text(
                        "$count",
                         style: TextStyle(fontSize:20, fontWeight:FontWeight.bold),
                      ),
                      SizedBox(width: 8,),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:Color.fromARGB(255,161,157,218)
                        ),
                        child: IconButton(
                          onPressed:(){
                            decreasecoun(widget.id);
                          } ,
                          icon: Icon(Icons.remove),
                        ) ,
                      ),
                      SizedBox(width:8 ,),
                      Spacer(),
                      Text(
                        "Total:"
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right:10),
                        child: Text(
                          "₹ ${widget.new_price * count}",
                          style: TextStyle(
                            fontSize: 20, fontWeight:FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          ),


    );
  }
}
