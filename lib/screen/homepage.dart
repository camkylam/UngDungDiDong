import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/auth/signout.dart';
import 'package:myproject_app/screen/cartproduct.dart';
import 'package:myproject_app/screen/detailScreen.dart';
import 'package:myproject_app/screen/listproduct.dart';
import 'package:myproject_app/screen/shop.dart';

import '../provider/category_provider.dart';
import '../provider/product_provider.dart';
import 'singproduct.dart';
import '../model/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

CategoryProvider? categoryProvider;
ProductProvider? productProvider;

class _HomePageState extends State<HomePage> {
  Widget _buildCategoryProduct({required String image, required int color}) {
    return CircleAvatar(
      maxRadius: 43,
      backgroundColor: const Color.fromARGB(255, 248, 248, 111),
      child: Container(
        height: 50,
        child: Image(
          image: AssetImage("images/$image"),
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text(
              "Welcome to MyApp",
              style: TextStyle(
                  color: Color.fromARGB(255, 47, 115, 233), fontSize: 25),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("images/anh1.jpg"),
            ),
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 153, 224, 149)),
            accountEmail: Text(
              "",
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Color.fromARGB(255, 8, 230, 22),
            ),
            title: const Text(
              "Home",
              style: TextStyle(
                  color: Color.fromARGB(255, 14, 220, 21), fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Giỏ hàng'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const CartScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Sản Phẩm'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const Shop(),
                ),
              );
            },
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const SignOut(),
                ),
              );
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Đăng xuất"),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlider() {
    return Container(
      height: 210,
      child: Carousel(
        autoplay: true,
        showIndicator: false,
        images: const [
          AssetImage("images/b1.jpg"),
          AssetImage("images/bia1.jpg"),
          AssetImage("images/bia2.jpg"),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    List<Product> TraiCayViet = categoryProvider!.getTraiCayVietList;
    List<Product> TraiCayNhapKhau = categoryProvider!.getTraiCayNhapKhauList;
    List<Product> TraiCayBocSan = categoryProvider!.getTraiCayBocSanList;
    List<Product> TraiCayKho = categoryProvider!.getTraiCayKhoList;
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                "Loại sản phẩm",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          child: Row(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => ListProduct(
                          name: "Trái cây Nhập khẩu",
                          snapShot: TraiCayNhapKhau,
                        ),
                      ),
                    );
                  },
                  child: _buildCategoryProduct(
                      image: "bia4.png", color: 0xff33dcfd)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => ListProduct(
                        name: "Trái cây Việt",
                        snapShot: TraiCayViet,
                      ),
                    ),
                  );
                },
                child:
                    _buildCategoryProduct(image: "bia6.png", color: 0xff33dcfd),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => ListProduct(
                        name: "Trái cây bóc sẵn",
                        snapShot: TraiCayBocSan,
                      ),
                    ),
                  );
                },
                child: _buildCategoryProduct(
                    image: "icon_2.png", color: 0xff33dcfd),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => ListProduct(
                        name: "Trái cây khô",
                        snapShot: TraiCayKho,
                      ),
                    ),
                  );
                },
                child: _buildCategoryProduct(
                    image: "icon_1.png", color: 0xff33dcfd),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context);

    categoryProvider!.getTraiCayVietData();
    categoryProvider!.getTraiCayNhapKhauData();
    categoryProvider!.getTraiCayBocSanData();
    categoryProvider!.getTraiCayKhoData();
    productProvider = Provider.of<ProductProvider>(context);
    productProvider!.getHomeFeatureData();
    productProvider!.getFeatureData();
    productProvider!.getNewAchivesData();
    return Scaffold(
      key: _key,
      drawer: _buildMyDrawer(),
      appBar: AppBar(
        title: const Text(
          "Trang chủ",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 31, 211, 11),
        leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              _key.currentState?.openDrawer();
            }),
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
                  _buildImageSlider(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildCategory(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildFeature(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildNewAchives(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFeature() {
    List<Product> featureProduct = productProvider!.getfeatureList;
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Sản phẩm nổi bật nhất",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => ListProduct(
                            name: "Sản phẩm nổi bật nhất",
                            snapShot: featureProduct,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Xem tất cả",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider!.getfeatureList.map((e) {
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
        ),
      ],
    );
  }

  Widget _buildNewAchives() {
    List<Product> newAchivesProduct = productProvider!.getNewAchivesList;
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Sản phẩm bán chạy nhất",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => ListProduct(
                            name: "Sản phẩm bán chạy nhất",
                            snapShot: newAchivesProduct,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Xem tất cả",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider!.getNewAchivesList.map((e) {
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
        ),
      ],
    );
  }
}
