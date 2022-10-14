import 'package:ecommerce/const/text-style.dart';
import 'package:ecommerce/model/productmodel.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductModel> productList = [];
  // @override
  // void didChangeDependencies() async {
  //   // TODO: implement didChangeDependencies

  //   CustomeHttp().fetchProductData();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var productprovider =
        Provider.of<ProductProvider>(context).getProductData();

    productList = Provider.of<ProductProvider>(context).productList;

    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ListView.separated(
          itemCount: productList.length,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 15,
            );
          },
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: height * 0.2,
              child: Card(
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              image: DecorationImage(
                                  // image: NetworkImage(
                                  //     "https://apihomechef.antopolis.xyz/images/${productList[index].image ?? ""}")

                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'https://images.unsplash.com/photo-1609167921178-e295a98f808f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80'))),
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${productList[index].name}',
                                      style:
                                          myStyle(fw: FontWeight.w600, fs: 18),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color:
                                              productList[index].isAvailable ==
                                                      1
                                                  ? Color(0xff2DCC70)
                                                  : Colors.red),
                                      child: productList[index].isAvailable == 1
                                          ? Text(
                                              'Available',
                                              style: myStyle(clr: Colors.white),
                                            )
                                          : Text(
                                              "Out Of stock",
                                              style: myStyle(clr: Colors.white),
                                            ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Price',
                                          style: myStyle(
                                              fw: FontWeight.w500,
                                              clr: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          '${productList[index].price![0].originalPrice}',
                                          style: myStyle(fw: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Discount Price',
                                          style: myStyle(
                                              fw: FontWeight.w500,
                                              clr: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          '${productList[index].price![0].discountedPrice}',
                                          style: myStyle(fw: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    productList[index].isAvailable == 1
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Quantity',
                                                style: myStyle(
                                                    fw: FontWeight.w500,
                                                    clr: Colors.grey),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                '${productList[index].stockItems![0].quantity}',
                                                style: myStyle(
                                                    fw: FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text(
                                                'Quantity',
                                                style: myStyle(
                                                    fw: FontWeight.w500,
                                                    clr: Colors.grey),
                                              ),
                                              Text('0'),
                                            ],
                                          )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            );
          }),
    ));
  }
}
