import 'package:flutter/material.dart';
import 'package:myproject_app/screen/homepage.dart';
import 'cartproduct.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  const DetailScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.price});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count = 1;
  late ProductProvider productProvider;

  Widget _buildImage() {
    return Center(
      child: Container(
        width: 350,
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(13),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(widget.image),
              )),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameToDescriptionPart() {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                "${widget.price.toString()}1kg",
                style: const TextStyle(
                  color: Color(0xff9b96d6),
                  fontSize: 18,
                ),
              ),
              const Text(
                "Mô tả",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _builDiscription() {
    return Container(
      height: 170,
      child: Wrap(
        children: const <Widget>[
          Text(
            "Thành phần trong thịt quả đào chứa chất màu, đường, axít hữu cơ, vitamin và ít tinh dầu. Đào còn là nguồn niacin, thiamin, kali và canxi tuyệt vời. Đào cũng có hàm lượng cao beta-caroten - một chất chống ôxy hóa chuyển thành vitamin A. Nó rất cần cho sức khỏe của tim và mắt. Người có chế độ ăn giàu hàm lượng vitamin A ít bị đục thủy tinh thể hơn. Lượng chất chống ôxy hóa trong quả đào cũng hỗ trợ duy trì hệ tiết niệu và tiêu hóa. Nó cũng được coi là một chất làm sạch và giải độc cho thận.",
            style: TextStyle(
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuentityPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Số lượng",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                child: const Icon(Icons.remove),
                onTap: () {
                  setState(
                    () {
                      if (count > 0.5) {
                        count--;
                      }
                    },
                  );
                },
              ),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                child: const Icon(Icons.add),
                onTap: () {
                  setState(() {
                    count++;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonPart() {
    return Container(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.black, backgroundColor: Colors.green),
        child: const Text(
          "Thêm vào giỏ hàng",
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          productProvider.getCartData(
              name: widget.name,
              image: widget.image,
              price: widget.price,
              quentity: count);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => const CartScreen(),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Chi tiết sản phẩm",
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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomePage(),
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
      body: Container(
        child: ListView(
          children: <Widget>[
            _buildImage(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildNameToDescriptionPart(),
                  _builDiscription(),
                  const SizedBox(
                    height: 30,
                  ),
                  /*_buildSizePart(),*/
                  _buildQuentityPart(),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildButtonPart(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
