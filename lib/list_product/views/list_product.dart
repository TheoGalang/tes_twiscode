import 'package:flutter/material.dart';

import 'package:test_twistcode/detail_product.dart';
import 'package:test_twistcode/list_product/models/product_model.dart';
import 'package:test_twistcode/list_product/models/product_order.dart';
import 'package:test_twistcode/list_product/services/product_service.dart';

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var result = await ProductService().getProducts();

    setState(() {
      productlist = result;
    });
  }

  List<Product> productlist = [];
  List<ProductOrder> productorder = [];
  CardProduct(Product product, BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      borderOnForeground: true,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      // color: Colors.indigo,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: 400,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/250?image=9'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      "Rp" + product.price + ",-",
                      style: TextStyle(fontSize: 15),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.add_location,
                            size: 10,
                          ),
                        ),
                        Text(
                          product.locationName,
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.person,
                            size: 10,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            product.addedUsername,
                            style: TextStyle(fontSize: 15),
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  child: MaterialButton(
                    padding: EdgeInsets.all(10),
                    height: 10.0,
                    minWidth: 70.0,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: new Text("Add to Cart"),
                    onPressed: () => {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                  "Barang berhasl ditambahkan ke keranjang"),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.orange),
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: Text("Oke"),
                                )
                              ],
                            );
                          }),
                      productorder.add(
                        ProductOrder(product: product, quantity: 1),
                      ),
                    },
                    splashColor: Colors.redAccent,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  child: product.isHalal == "1"
                      ? Image.asset('assets/images/halal.png')
                      : Container(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LIST PRODUK"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailProduct(productOrderList: productorder)));
              },
              icon: Icon(Icons.shopping_cart, color: Colors.white))
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 4 / 6,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) =>
            CardProduct(productlist[index], context),
        itemCount: productlist.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 1)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.format_list_bulleted),
                  Text("Category"),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.filter_list),
                  Text("Filter"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
