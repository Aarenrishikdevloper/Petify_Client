import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/models/product_model.dart';
import 'package:mobile/provider/CartProvider.dart';
import 'package:provider/provider.dart';

class Viewproduct extends StatefulWidget {
  const Viewproduct({super.key});

  @override
  State<Viewproduct> createState() => _ViewproductState();
}

class _ViewproductState extends State<Viewproduct> {
  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      backgroundColor: const Color(0xFFeeedf2),
      appBar: AppBar(
        title: const Text("Product Details"),
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl:argument.image,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.scaleDown,
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        argument.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "₹ ${argument.oldPrice}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 97, 97, 97),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "₹ ${argument.newPrice}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_downward,
                            size: 20,
                            color: Color.fromARGB(255, 76, 175, 79),
                          ),
                          Text(
                            "${Constants().discountPercent(argument.oldPrice, argument.newPrice)}%",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 76, 175, 79),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      argument.maxQuantity == 0
                          ? const Text(
                              "Out og Stock",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 76, 175, 79),
                              ),
                            )
                          : Text(
                              "Only ${argument.maxQuantity} left in stock",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 76, 175, 79),
                              ),
                            ),
                      SizedBox(height: 10),
                      Text(
                        argument.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 97, 97, 97),
                        ),
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (argument.maxQuantity != 0)
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width * .5,
                      child: ElevatedButton(
                        onPressed: ()async {
                           String message = await  Provider.of<Cartprovider>(context, listen:false ).addToCart(argument.id, 1);
                           ScaffoldMessenger.of(context).showSnackBar(

                             SnackBar(content:Text(message))
                           );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 30, 136, 229),
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                          shape: const RoundedRectangleBorder(),
                        ),
                        child: const Text("Add to Cart"),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width * .5,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          foregroundColor: Color.fromARGB(255, 30, 136, 229),
                          shape: const RoundedRectangleBorder(),
                        ),
                        child: const Text("Buy Now"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
