import 'package:ecom_admin/models/product.dart';
import 'package:ecom_admin/provider/products.dart';
import 'package:ecom_admin/screen/editscreen.dart';
import 'package:ecom_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemBuild extends StatelessWidget {
  final int id;
  const ItemBuild({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return Card(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: Utils.sizeHeight(context) / 11,
                  width: Utils.sizeWidth(context) / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(product.thumbnailUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: Utils.sizeHeight(context) / 11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('Giá: ${product.price}'),
                      Text('Sale: -${product.discount}%'),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => EditScreen(),
                          settings: RouteSettings(arguments: id),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                ),
                Container(
                  child: IconButton(
                    onPressed: () {
                      context
                          .read<ProductProvider>()
                          .deleteProduct(product.proId)
                          .then((_) => Utils.showToast('Xóa thành công...'));
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
