import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

import "../model/cartmodel.dart";
import "../model/product.dart";

class ProductProvider with ChangeNotifier {
  List<Product> feature = [];
  late Product featureData;

  List<CartModel> cartModelList = [];
  late CartModel cartModel;

  List<CartModel> checkOutModelList = [];
  late CartModel checkOutModel;

  void deleteCartProduct(int index) {
    cartModelList.removeAt(index);
    notifyListeners();
  }

  void deleteOrderProduct(int index) {
    cartModelList.removeAt(index);
    notifyListeners();
  }

  void getCartData(
      {required String name,
      required String image,
      required int quentity,
      required double price}) {
    cartModel =
        CartModel(price: price, name: name, image: image, quentity: quentity);
    cartModelList.add(cartModel);
  }

  List<CartModel> get getCartModelList {
    return List.from(cartModelList);
  }

  int get getCartModelListLength {
    return cartModelList.length;
  }

  Future<void> getFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("featureproduct").get();
    for (var element in featureSnapShot.docs) {
      featureData = Product(
        name: element.get("name"),
        image: element.get("image"),
        price: element.get("price"),
      );
      newList.add(featureData);
      notifyListeners();
    }
    feature = newList;
  }

  List<Product> get getfeatureList {
    return feature;
  }

  List<Product> homeFeature = [];

  Future<void> getHomeFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("shop").get();
    for (var element in featureSnapShot.docs) {
      featureData = Product(
          name: element.get("name"),
          image: element.get("image"),
          price: element.get("price"));
      newList.add(featureData);
    }
    homeFeature = newList;
    notifyListeners();
  }

  List<Product> get getHomeFeatureList {
    return homeFeature;
  }

  List<Product> newAchives = [];
  late Product newAchivesData;

  Future<void> getNewAchivesData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("newachive").get();
    for (var element in featureSnapShot.docs) {
      newAchivesData = Product(
        name: element.get("name"),
        image: element.get("image"),
        price: element.get("price"),
      );
      newList.add(newAchivesData);
      notifyListeners();
    }
    newAchives = newList;
  }

  List<Product> get getNewAchivesList {
    return newAchives;
  }
}
