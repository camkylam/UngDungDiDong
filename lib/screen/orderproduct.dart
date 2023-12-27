import 'package:flutter/material.dart';
import 'package:myproject_app/provider/product_provider.dart';
import 'package:myproject_app/screen/cartsingleproduct.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late ProductProvider productProvider;

  Widget _buildBottomDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          endName,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    double subTotal = 0;
    double shipping = 60;
    double total;
    for (var element in productProvider.getCartModelList) {
      subTotal += element.price * element.quentity;
    }
    total = subTotal + shipping;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Đặt hàng",
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 31, 211, 11),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const HomePage(),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        //width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.black, backgroundColor: Colors.green),
          child: const Text(
            "Đặt hàng",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomePage(),
              ),
            );
          },
        ),
      ),
      body: Container(
        //height: 160,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 0.5, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: productProvider.getCartModelListLength,
                itemBuilder: (ctx, index) => CartSingleProduct(
                  isCount: true,
                  index: index,
                  image: productProvider.getCartModelList[index].image,
                  name: productProvider.getCartModelList[index].name,
                  price: productProvider.getCartModelList[index].price,
                  quentity: productProvider.getCartModelList[index].quentity,
                ),
              ),
            ),
            SizedBox(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildBottomDetail(
                      startName: "Số tiền thanh toán",
                      endName: "${subTotal.toStringAsFixed(2)} đ",
                    ),
                    _buildBottomDetail(
                      startName: "Phí vận chuyển",
                      endName: "${shipping.toStringAsFixed(2)} đ",
                    ),
                    _buildBottomDetail(
                      startName: "Tổng thanh toán",
                      endName: "${total.toStringAsFixed(2)} đ",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
