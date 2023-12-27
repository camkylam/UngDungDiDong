import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/screen/detailScreen.dart';
import 'package:myproject_app/screen/listproduct.dart';
import '../model/product.dart';
import '../provider/product_provider.dart';
import '../provider/product_provider.dart';
import 'homepage.dart';
import 'singproduct.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../provider/category_provider.dart';
import 'package:provider/provider.dart';

import 'package:myproject_app/provider/category_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

CategoryProvider? categoryProvider;
ProductProvider? productProvider;

var feature;
var newAchives;
var TraiCayViet;
var TraiCayNhapKhau;

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    productProvider!.getFeatureData();
    productProvider!.getHomeFeatureData();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cửa hàng",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 31, 211, 11),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const HomePage(),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //_buildCategory(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildHomeFeature(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeFeature() {
    List<Product> featureHomeProduct = productProvider!.getHomeFeatureList;
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "Tất cả sản phẩm",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 24, 220, 242)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 600,
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            scrollDirection: Axis.vertical,
            children: productProvider!.getHomeFeatureList.map((e) {
              return Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                              name: e.name, price: e.price, image: e.image),
                        ),
                      );
                    },
                    child: SingleProduct(
                        name: e.name, price: e.price, image: e.image),
                  ),
                ],
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
