import 'package:ecom_admin/models/cartitem.dart';
import 'package:ecom_admin/models/order.dart';
import 'package:ecom_admin/models/usermodel.dart';
import 'package:ecom_admin/provider/orders.dart';
import 'package:ecom_admin/widget/neworder_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final OrderItem order;

  _NewOrderState({this.order});
  Future getOrder() async {
    return await Provider.of<Orders>(context, listen: false).fetchOrderUser();
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getOrder());
  }

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final wight = MediaQuery.of(context).size.width;
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      body: ordersData.orders.length == 0
          ? Center(
              child: Text('Không có đơn hàng nào'),
            )
          : RefreshIndicator(
              onRefresh: getOrder,
              child: ListView.builder(
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
              ),
            ),
    );
  }
}
