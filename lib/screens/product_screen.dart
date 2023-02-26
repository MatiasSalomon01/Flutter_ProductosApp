import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/providers/provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';


class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (context) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService)
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key,
    required this.productService,
  });

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct.picture),
                Positioned(
                  top: 60,
                  left: 25,
                  child: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios_new, color: Colors.white,))
                ),
                Positioned(
                  top: 60,
                  right: 25,
                  child: IconButton(onPressed: () async {
                    final picker = ImagePicker();
                    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

                    if(pickedFile == null){
                      print('no selecciono nada');
                      return;
                    }
                    print('tenemos imagen ${pickedFile.path}');
                    productService.updateSelectedProductImage(pickedFile.path);
                  }, 
                  icon: Icon(Icons.camera_alt_outlined, color: Colors.white,))
                ),             
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100,)  
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
      onPressed: productService.isSaving 
        ? null 
        : () async {
        if (!productForm.isValidForm()) return;

        final String? imageUrl = await productService.uploadImage();

        if(imageUrl != null) productForm.product.picture = imageUrl;

        await productService.saveOrCreateProduct(productForm.product);
      },
      child: productService.isSaving 
      ? CircularProgressIndicator(color: Colors.white,)
      : Icon(Icons.save_outlined),
    ),
   );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10,),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del Producto', 
                  labelText: 'Nombre:'
                )
              ),
              SizedBox(height: 30,),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if(double.tryParse(value) == null){
                    product.price = 0;
                  }else{
                    product.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150', 
                  labelText: 'Precio:'
                )
              ),
              SizedBox(height: 30,),
              SwitchListTile.adaptive(
                value: product.available, 
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: productForm.updateAvailability,
              ),
              SizedBox(height: 30,)
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 5
        )
      ]
    );
  }
}