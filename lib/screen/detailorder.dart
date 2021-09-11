import 'package:ecom_admin/models/cartitem.dart';
import 'package:ecom_admin/models/order.dart';
import 'package:ecom_admin/provider/orders.dart';
import 'package:ecom_admin/utils/global.dart';
import 'package:ecom_admin/utils/logger.dart';
import 'package:ecom_admin/utils/utils.dart';
import 'package:ecom_admin/widget/buttom_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailOrder extends StatefulWidget {
  final OrderItem order;

  const DetailOrder({Key key, this.order}) : super(key: key);

  @override
  _DetailOrderState createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  Future getInfo() async {
    await Provider.of<Orders>(context, listen: false)
        .getUserByUid(widget.order.orderBy)
        .then((_) => Provider.of<Orders>(context, listen: false)
            .getAddressById(widget.order.orderBy, widget.order.addressId));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
  }

  @override
  Widget build(BuildContext context) {
    final devLog = logger;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          //width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Color(0xFFe6f3f5),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            backgroundImage: AssetImage(Global.avatar),
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.watch<Orders>().username),
                              Text(''),
                              Text(
                                  '${Utils.dayData(widget.order.orderTime)} at ${Utils.hourData(widget.order.orderTime)}',
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      Text('OrderID: ${widget.order.id}',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
              cardItemView(Icon(Icons.phone_forwarded, color: Colors.red),
                  context.watch<Orders>().phone, 'Call', () {
                print('Call now');
              }),
              cardItemView(Icon(Icons.email, color: Colors.red),
                  context.watch<Orders>().userOrder.email, 'Email', () {
                print('Email');
              }),
              cardItemView(Icon(Icons.location_on, color: Colors.red),
                  context.watch<Orders>().address, 'Navigate', () {
                print('Navigate');
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Message',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 3),
                child: Text(Global.mesage, maxLines: 3),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
              ),
              Container(
                height: 210,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: builDataTable(),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtomWidget(
                      onPress: () {
                        print('Print');
                      },
                      backgroundColor: Colors.red[200],
                      textColor: Colors.white,
                      text: 'Print Ivoice',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  cardItemView(Icon icon, String text, String textBtn, Function function) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    text,
                  ),
                ),
              ],
            ),
            ButtomWidget(
              onPress: function,
              backgroundColor: Colors.red[200],
              textColor: Colors.white,
              text: textBtn,
            ),
          ],
        ),
      ),
    );
  }

  builDataTable() {
    final colunms = ['Tên', 'SL', 'Đ.Giá', 'Sale', 'T.Tiền'];
    List<CartItem> list = widget.order.cartItem;
    return DataTable(
      dataRowHeight: 40,
      headingRowColor:
          MaterialStateColor.resolveWith((states) => Color(0xFFe6f3f5)),
      columns: getColumns(colunms),
      rows: getRows(list),
    );
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
