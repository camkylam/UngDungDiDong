import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product.dart';

class CategoryProvider with ChangeNotifier {
  List<Product> TraiCayViet = [];
  late Product TraiCayVietData;
  List<Product> TraiCayNhapKhau = [];
  late Product TraiCayNhapKhauData;
  List<Product> TraiCayBocSan = [];
  late Product TraiCayBocSanData;
  List<Product> TraiCayKho = [];
  late Product TraiCayKhoData;

  Future<void> getTraiCayVietData() async {
    List<Product> newList = [];
    QuerySnapshot TraiCayVietSnapShot =
        await FirebaseFirestore.instance.collection("TraiCayViet").get();
    for (var element in TraiCayVietSnapShot.docs) {
      TraiCayVietData = Product(
        image: element.get("image"),
        name: element.get('name'),
        price: element.get("price"),
      );
      newList.add(TraiCayVietData);
    }
    TraiCayViet = newList;
  }

  List<Product> get getTraiCayVietList {
    return TraiCayViet;
  }

  Future<void> getTraiCayNhapKhauData() async {
    List<Product> newList = [];
    QuerySnapshot TraiCayNhapKhauSnapShot =
        await FirebaseFirestore.instance.collection("TraiCayNhapKhau").get();
    for (var element in TraiCayNhapKhauSnapShot.docs) {
      TraiCayNhapKhauData = Product(
        image: element.get("image"),
        name: element.get("name"),
        price: element.get("price"),
      );
      newList.add(TraiCayNhapKhauData);
    }
    TraiCayNhapKhau = newList;
  }

  List<Product> get getTraiCayNhapKhauList {
    return TraiCayNhapKhau;
  }

  Future<void> getTraiCayBocSanData() async {
    List<Product> newList = [];
    QuerySnapshot TraiCayBocSanSnapShot =
        await FirebaseFirestore.instance.collection("TraiCayBocSan").get();
    for (var element in TraiCayBocSanSnapShot.docs) {
      TraiCayBocSanData = Product(
        image: element.get("image"),
        name: element.get("name"),
        price: element.get("price"),
      );
      newList.add(TraiCayBocSanData);
    }
    TraiCayBocSan = newList;
  }

  List<Product> get getTraiCayBocSanList {
    return TraiCayBocSan;
  }

  Future<void> getTraiCayKhoData() async {
    List<Product> newList = [];
    QuerySnapshot TraiCayKhoSnapShot =
        await FirebaseFirestore.instance.collection("TraiCayKho").get();
    for (var element in TraiCayKhoSnapShot.docs) {
      TraiCayKhoData = Product(
        image: element.get("image"),
        name: element.get("name"),
        price: element.get("price"),
      );
      newList.add(TraiCayKhoData);
    }
    TraiCayKho = newList;
  }

  List<Product> get getTraiCayKhoList {
    return TraiCayKho;
  }
}
