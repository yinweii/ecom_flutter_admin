import 'package:ecom_admin/models/cartitem.dart';
import 'package:ecom_admin/models/order.dart';
import 'package:ecom_admin/provider/orders.dart';
import 'package:ecom_admin/screen/detailorder_view.dart';
import 'package:ecom_admin/utils/global.dart';
import 'package:ecom_admin/utils/logger.dart';
import 'package:ecom_admin/utils/utils.dart';
import 'package:ecom_admin/widget/buttom_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewOrderWidget extends StatefulWidget {
  final OrderItem order;

  final String id;

  const NewOrderWidget({this.id, this.order});

  @override
  _NewOrderWidgetState createState() => _NewOrderWidgetState();
}

class _NewOrderWidgetState extends State<NewOrderWidget> {
  Future getUserById() async {
    return Provider.of<Orders>(context, listen: false)
        .getUserByUid(widget.order.orderBy);
  }

  @override
  void initState() {
    super.initState();
    getUserById();
  }
  // WidgetsBinding.instance.addPostFrameCallback((_) => );

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;

    final wight = MediaQuery.of(context).size.width;
    String text =
        'This is possible since .signInWithEmailAndPassword correctly throws Errors with defined codes, that we can grab to identify the error and handle things in the way the should be handled.';

    return Container(
      height: hight * 0.5,
      width: wight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 4),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      backgroundImage: AssetImage(Global.avatar),
                    ),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Text(context.watch<Orders>().username),
                        Text(Utils.changeText(widget.order.orderBy, 5, '...')),
                        Text(
                            '${Utils.dayData(widget.order.orderTime)} at ${Utils.hourData(widget.order.orderTime)}',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('OrderID: ${widget.order.id}'),
                  Text('Total: ${widget.order.total}'),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: widget.order.cartItem.length > 2 ? 210 : 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: builDataTable(),
              ),
            ),
          ),
          Divider(),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                Utils.changeText(text, 111, '...'),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtomWidget(
                  onPress: () {
                    print('Call...');
                  },
                  backgroundColor: Colors.orange[300],
                  textColor: Colors.orange[300],
                  text: 'Call'),
              ButtomWidget(
                  onPress: () {
                    Utils.navigatePage(
                        context, DetailOrder(order: widget.order));
                    print('Detal...');
                  },
                  backgroundColor: Colors.orange[300],
                  textColor: Colors.orange[300],
                  text: 'Details'),
              ButtomWidget(
                  onPress: () {
                    print('Cancel...');
                  },
                  backgroundColor: Colors.red[300],
                  textColor: Colors.white,
                  text: 'Cancel Orders'),
              ButtomWidget(
                  onPress: () {
                    print('Accept...');
                  },
                  backgroundColor: Colors.red[300],
                  textColor: Colors.white,
                  text: 'Accept'),
            ],
          ),
          Divider(thickness: 1, color: Colors.blue),
        ],
      ),
    );
  }

  builDataTable() {
    final colunms = ['Tên', 'SL', 'Đ.Giá', 'Sale', 'T.Tiền'];
    List<CartItem> list = widget.order.cartItem;
    return DataTable(columns: getColumns(colunms), rows: getRows(list));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column != null ? column : '0'),
          ))
      .toList();

  List<DataRow> getRows(List<CartItem> list) => list.map((CartItem item) {
        final totalRow = item.quantity *
            (item.price - ((item.price * item.discount) ~/ 100));
        final cells = [
          item.title,
          item.quantity,
          item.price,
          '-${item.discount}%',
          totalRow,
        ];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells
      .map((data) => DataCell(Text(data != null ? '$data ' : '0')))
      .toList();
}
