import 'package:ecom_admin/provider/products.dart';
import 'package:ecom_admin/utils/logger.dart';
import 'package:ecom_admin/widget/itembuild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PizzaTab extends StatefulWidget {
  const PizzaTab({Key key}) : super(key: key);

  @override
  _PizzaTabState createState() => _PizzaTabState();
}

class _PizzaTabState extends State<PizzaTab> {
  bool _isInit = true;
  bool _isLoading = false;
  Future getProduct() async {
    Provider.of<ProductProvider>(context, listen: false).getProduct(2);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context, listen: false)
          .getProduct(2)
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
