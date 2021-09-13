import 'package:ecom_admin/screen/editscreen.dart';
import 'package:ecom_admin/screen/menutab/drinktab.dart';
import 'package:ecom_admin/screen/menutab/pizzatab.dart';
import 'package:ecom_admin/screen/menutab/sandwich.dart';
import 'package:ecom_admin/utils/utils.dart';
import 'package:ecom_admin/widget/draw.dart';
import 'package:flutter/material.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
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
          actions: [
            IconButton(
                onPressed: () {
                  Utils.navigatePage(context, EditScreen());
                },
                icon: Icon(Icons.add))
          ],
          bottom: TabBar(
            controller: controller,
            tabs: <Tab>[
              Tab(child: Text('Pizza')),
              Tab(child: Text('Drink')),
              Tab(child: Text('Sandwich')),
            ],
          ),
        ),
        drawer: MyDrawer(),
        body: TabBarView(controller: controller, children: <Widget>[
          PizzaTab(),
          DrinkTab(),
          SandwichTab(),
        ]));
  }
}
