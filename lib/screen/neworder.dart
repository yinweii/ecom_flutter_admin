import 'package:ecom_admin/models/cartitem.dart';
import 'package:ecom_admin/models/order.dart';
import 'package:ecom_admin/models/usermodel.dart';
import 'package:ecom_admin/provider/orders.dart';
import 'package:ecom_admin/widget/neworder_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final OrderItem order;

  Future _future;

  _NewOrderState({this.order});
  Future getOrder() async {
    return await Provider.of<Orders>(context, listen: false).fetchOrderUser();
  }

  @override
  void initState() {
    super.initState();

    _future = getOrder();
  }

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final wight = MediaQuery.of(context).size.width;
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
        body: FutureBuilder(
      future: _future,
      builder: (context, snnapshot) {
        if (snnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return new ListView.builder(
            itemCount: ordersData.orders.length,
            itemBuilder: (context, index) {
              return Container(
                height: hight * 0.5,
                width: wight,
                child: NewOrderWidget(
                  order: ordersData.orders[index],
                ),
              );
            },
          );
        }
      },
    ));
  }
}
