import 'package:flutter/material.dart';

import 'list_product/models/product_order.dart';

class DetailProduct extends StatefulWidget {
  List<ProductOrder> productOrderList = [];
  DetailProduct({required this.productOrderList});

  @override
  _DetailProductState createState() =>
      _DetailProductState(productOrderList: this.productOrderList);
}

class _DetailProductState extends State<DetailProduct> {
  double sum = 0.0;
  List<ProductOrder> productOrderList = [];
  _DetailProductState({required this.productOrderList});

  ListProduct(ProductOrder productOrder, int index) {
    return Card(
      shadowColor: Colors.black,
      borderOnForeground: true,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/250?image=9'),
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  productOrder.product.title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Text(
                        "Rp" +
                            (double.parse(productOrder.product.price) *
                                    productOrderList[index].quantity)
                                .toString() +
                            ",-",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (productOrderList[index].quantity == 0) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          "Tidak bisa mengurangi kuantitas lagi"),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.orange),
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: Text("Close"),
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              productOrderList[index].quantity =
                                  productOrderList[index].quantity - 1;
                            }

                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red),
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            productOrder.quantity.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            productOrderList[index].quantity =
                                productOrderList[index].quantity + 1;
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.lightGreen),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DETAIL PRODUK"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 100),
            child: ListView.builder(
              itemCount: productOrderList.length,
              itemBuilder: (context, index) =>
                  ListProduct(productOrderList[index], index),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              child: Card(
                shadowColor: Colors.black,
                borderOnForeground: true,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: Text(
                                    "Total Harga",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: Text(
                                    productOrderList.length > 0
                                        ? "Rp " +
                                            productOrderList
                                                .map<double>((e) =>
                                                    double.parse(
                                                        e.product.price) *
                                                    e.quantity)
                                                .reduce((value, element) =>
                                                    value + element)
                                                .toStringAsFixed(2) +
                                            " ,-"
                                        : "0",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  ),
                                ),
                              ]),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text("Terima Kasih Telah Order"),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.orange),
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: Text("Close"),
                                      )
                                    ],
                                  );
                                });
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )),
                          child: Text("Order"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
