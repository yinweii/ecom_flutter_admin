import 'package:ecom_admin/provider/authprovider.dart';
import 'package:ecom_admin/screen/authscreen/login.dart';
import 'package:ecom_admin/screen/home.dart';
import 'package:ecom_admin/screen/menuview.dart';
import 'package:ecom_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue[200],
                    radius: 40,
                  ),
                  Text('Phong Goodboizz')
                ],
              ),
            ),
          ),
          Divider(height: 6, thickness: 6),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('All Order'),
            onTap: () {
              Utils.navigateReplace(context, Home());
            },
          ),
          Divider(height: 6, thickness: 6),
          ListTile(
            leading: Icon(Icons.card_travel),
            title: Text('Menu'),
            onTap: () {
              Utils.navigateReplace(context, MenuView());
            },
          ),
          Divider(height: 6, thickness: 6),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('LogOut'),
              onTap: () async {
                await context
                    .read<AuthProvider>()
                    .signOut()
                    .then((_) => Utils.navigateReplace(context, Login()));
              }),
          Divider(height: 6, thickness: 6),
        ],
      ),
    );
  }
}
