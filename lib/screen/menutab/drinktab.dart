import 'package:ecom_admin/provider/products.dart';
import 'package:ecom_admin/utils/logger.dart';
import 'package:ecom_admin/widget/itembuild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrinkTab extends StatefulWidget {
  const DrinkTab({Key key}) : super(key: key);

  @override
  _DrinkTabState createState() => _DrinkTabState();
}

class _DrinkTabState extends State<DrinkTab> {
  var _isInit = true;
  var _isLoading = false;
  Future getProduct() async {
    Provider.of<ProductProvider>(context, listen: false).getProduct(1);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context, listen: false)
          .getProduct(1)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final devLog = logger;
    final productData = Provider.of<ProductProvider>(context);
    final product = productData.listProduct;
    return Scaffold(
      body: _isLoading
          ? Center(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : RefreshIndicator(
              onRefresh: getProduct,
              child: ListView.builder(
                itemCount: product.length,
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: product[index],
                  child: ItemBuild(),
                ),
              ),
            ),
    );
  }
}
