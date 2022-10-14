import 'package:ecommerce/const/text-style.dart';
import 'package:ecommerce/provider/orderprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    var orderprovider = Provider.of<OrderProvider>(context).getOrderData();
    var orderList = Provider.of<OrderProvider>(context).orderList;
    bool status = false;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: ListView.separated(
            separatorBuilder: ((context, index) => SizedBox(
                  height: 10,
                )),
            shrinkWrap: true,
            itemCount: orderList.length,
            itemBuilder: (context, index) {
              return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff326D00)
                        // gradient: LinearGradient(
                        //   begin: Alignment.topLeft,
                        //   end: Alignment(0.8, 1),
                        //   colors: <Color>[
                        //     Color(0xff5b0060).withOpacity(.7),
                        //     Color(0xff870160).withOpacity(.7),
                        //     Color(0xffac255e).withOpacity(.7),
                        //     Color(0xffca485c),
                        //     Color(0xffe16b5c),
                        //     Color(0xfff39060),
                        //     Color(0xffffb56b),
                        //   ], // Gradient from https://learnui.design/tools/gradient-generator.html
                        //   tileMode: TileMode.mirror,
                        // ),
                        ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${orderList[index].user!.name}',
                                  style: myStyle(fs: 20, clr: Colors.white),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Price  ',
                                      style: myStyle(
                                          fw: FontWeight.bold,
                                          fs: 18,
                                          clr: Colors.white),
                                    ),
                                    Text(
                                      '${orderList[index].price} Taka ',
                                      style: myStyle(fs: 16, clr: Colors.white),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: orderList[index]
                                                  .orderStatus!
                                                  .orderStatusCategory!
                                                  .name ==
                                              'Ongoing'
                                          ? Colors.blue
                                          : Colors.green),
                                  child: Text(
                                    '${orderList[index].orderStatus!.orderStatusCategory!.name}',
                                    style: myStyle(clr: Colors.white, fs: 18),
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Jiffy(orderList[index].orderDateAndTime)
                                      .format("MM do yy, h:mm:ss a"),
                                  style: myStyle(clr: Colors.white),
                                ),
                                // SizedBox(
                                //   height: 50,
                                // ),
                                Row(
                                  children: [
                                    Text(
                                      'Payment',
                                      style: myStyle(
                                          clr: Colors.white,
                                          fw: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      child: FlutterSwitch(
                                        width: 80.0,
                                        height: 35.0,
                                        valueFontSize: 18.0,
                                        toggleSize: 22.0,
                                        activeText: '1',
                                        inactiveText: '0',
                                        activeColor: Colors.teal,
                                        inactiveColor: Colors.black,
                                        value: orderList[index]
                                                    .payment!
                                                    .paymentStatus ==
                                                0
                                            ? false
                                            : true,
                                        borderRadius: 30.0,
                                        padding: 8.0,
                                        showOnOff: true,
                                        onToggle: (val) {
                                          setState(() {
                                            status = val;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
