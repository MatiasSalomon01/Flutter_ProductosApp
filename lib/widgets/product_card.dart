import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        height: 400,
        width: double.infinity,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(product.picture),

            _ProductDetails(title: product.name, subTitle: product.id),

            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(priceTag: product.price)
            ),

            if(!product.available)
              Positioned(
                top: 0,
                left: 0,
                child: _NotAvailable()
              )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 6),
        blurRadius: 10
      )
    ]
  );
}

class _NotAvailable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No Disponible',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {

  final double priceTag;

  const _PriceTag({super.key, required this.priceTag});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$$priceTag',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {

  final String title;
  final String? subTitle;

  const _ProductDetails({super.key, required this.title,  this.subTitle});

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50) ,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 70,
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, 
              style: const TextStyle(
                color: Colors.white, 
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subTitle ?? '', 
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15
              ),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

class _BackgroundImage extends StatelessWidget {

  final String? url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: 400,
        width: double.infinity,
        child: url == null 
        ? const Image(
            image: AssetImage('assets/no-image.png'),
            fit: BoxFit.cover,
          ) 
        : FadeInImage(
            placeholder: const AssetImage('assets/jar-loading.gif'),
            //image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
            image: NetworkImage(url!),
            fit: BoxFit.cover,
          ),
      ),
    );
  }
}