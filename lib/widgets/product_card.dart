import 'package:flutter/material.dart';
// import 'global_variables.dart';

class ProductCard extends StatelessWidget {
  final int id;
  final String title;
  final double price;
  final String imageUrl;
  final List<int>? sizes;
  final String? company;

  const ProductCard({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl, 
    this.sizes,
    this.company,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: id.isEven
            ? Color.fromRGBO(216, 240, 253, 1)
            : Color.fromRGBO(245, 247, 249, 1),
        borderRadius: BorderRadius.circular(30),
        // shape: BoxShape.circle
      ),
      margin: EdgeInsets.all(15),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            '\$$price',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                height: 170,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
