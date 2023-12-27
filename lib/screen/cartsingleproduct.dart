import 'package:flutter/material.dart';
import 'package:myproject_app/provider/product_provider.dart';
import 'package:myproject_app/screen/cartproduct.dart';
import 'package:provider/provider.dart';

class CartSingleProduct extends StatefulWidget {
  final String name;
  final String image;
  final int index;
  int quentity;
  final double price;
  final bool isCount;

  CartSingleProduct({
    super.key,
    required this.index,
    required this.image,
    required this.name,
    required this.price,
    required this.quentity,
    required this.isCount,
  });

  @override
  State<CartSingleProduct> createState() => _CartSingleProductState();
}

class _CartSingleProductState extends State<CartSingleProduct> {
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    return Container(
      height: 150,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 130,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.image),
                    ),
                  ),
                ),
                Container(
                  height: 140,
                  width: 200,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.name,
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  productProvider
                                      .deleteCartProduct(widget.index);
                                },
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${widget.price.toString()}/1kg",
                          style: const TextStyle(
                              color: Color(0xff9b96d6),
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 35,
                          width: widget.isCount == false ? 120 : 90,
                          color: const Color(0xfff2f2f2),
                          child: widget.isCount == false
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: const Icon(Icons.remove),
                                      onTap: () {
                                        setState(
                                          () {
                                            if (widget.quentity > 1) {
                                              widget.quentity--;
                                              productProvider.deleteCartProduct(
                                                  widget.index);
                                              productProvider.getCartData(
                                                  quentity: widget.quentity,
                                                  image: widget.image,
                                                  name: widget.name,
                                                  price: widget.price);
                                            }
                                          },
                                        );
                                      },
                                    ),
                                    Text(
                                      widget.quentity.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    GestureDetector(
                                      child: const Icon(Icons.add),
                                      onTap: () {
                                        setState(() {
                                          widget.quentity++;
                                          productProvider
                                              .deleteCartProduct(widget.index);
                                          productProvider.getCartData(
                                              quentity: widget.quentity,
                                              image: widget.image,
                                              name: widget.name,
                                              price: widget.price);
                                        });
                                      },
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Text("Số lượng"),
                                    Text(
                                      widget.quentity.toString(),
                                      style: const TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
