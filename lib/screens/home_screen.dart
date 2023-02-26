import 'package:flutter/material.dart';
import 'package:productos_app/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'product'),
          child: ProductCard()
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {},
        child: Icon(Icons.add),
      ),
   );
  }
}