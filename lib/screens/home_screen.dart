import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if(productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        leading: IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          }, 
        ),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            productsService.selectedProduct = productsService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(product: productsService.products[index],)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:() {
          productsService.selectedProduct = Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
      ),
   );
  }
}