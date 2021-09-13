import 'package:ecom_admin/screen/neworder_view.dart';
import 'package:ecom_admin/screen/passorder_view.dart';
import 'package:ecom_admin/widget/draw.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: controller,
            tabs: <Tab>[
              Tab(child: Text('New Orders')),
              Tab(child: Text('Past Orders')),
            ],
          ),
        ),
        drawer: MyDrawer(),
        body: TabBarView(controller: controller, children: <Widget>[
          NewOrder(),
          PastOrder(),
        ]));
  }
}
