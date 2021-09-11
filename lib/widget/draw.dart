import 'package:ecom_admin/provider/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Name'),
            onTap: () {},
          ),
          Divider(height: 6, thickness: 6),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('All Order'),
            onTap: () {},
          ),
          Divider(height: 6, thickness: 6),
          ListTile(
            leading: Icon(Icons.card_travel),
            title: Text('Menu'),
            onTap: () {},
          ),
          Divider(height: 6, thickness: 6),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('LogOut'),
              onTap: () async {
                await context.read<AuthProvider>().signOut();
              }),
          Divider(height: 6, thickness: 6),
        ],
      ),
    );
  }
}
