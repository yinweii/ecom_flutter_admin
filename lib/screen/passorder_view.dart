import 'package:ecom_admin/models/order.dart';
import 'package:ecom_admin/provider/orders.dart';
import 'package:ecom_admin/utils/global.dart';
import 'package:ecom_admin/utils/logger.dart';
import 'package:ecom_admin/widget/neworder_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PastOrder extends StatefulWidget {
  final OrderItem order;
  final devLog = logger;

  PastOrder({Key key, this.order}) : super(key: key);
  @override
  _PastOrderState createState() => _PastOrderState();
}

class _PastOrderState extends State<PastOrder> {
  Future getOrder() async {
    return await Provider.of<Orders>(context, listen: false)
        .fetchOrderUser(Global.accept_order);
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getOrder();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      body: context.watch<Orders>().isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ordersData.orders.length == 0
              ? Center(
                  child: Text('Không có đơn hàng nào'),
                )
              : RefreshIndicator(
                  onRefresh: getOrder,
                  child: ListView.builder(
                    itemCount: ordersData.orders.length,
                    itemBuilder: (context, index) {
                      return NewOrderWidget(
                        typeOrder: 1,
                        order: ordersData.orders[index],
                      );
                    },
                  ),
                ),
    );
  }
}
