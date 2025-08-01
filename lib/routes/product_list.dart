import 'package:flutter/material.dart';
import 'package:shopping_app/routes/product_details.dart';
import '../widgets/product_card.dart';
import '../global_variables.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final border = const OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
    borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
  );
  final chipColor = const Color.fromRGBO(245, 247, 249, 1);

  final List<String> filters = ['All', 'Nike', 'Adidas', 'Bata'];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0]; // Default to "All"
  }

  // ✅ Function to filter products
  List<Map<String, dynamic>> get filteredProducts {
    if (selectedFilter == 'All') {
      return products;
    } else {
      return products
          .where((product) => product['company'] == selectedFilter)
          .toList();
    }
  }

  // ✅ Extracted item builder function (Uses your original design)
  Widget buildProductCard(BuildContext context, int index) {
    final product = filteredProducts[index];

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetails(product: product),
        ));
      },
      child: ProductCard(
        id: product['id'],
        title: product['title'],
        price: product['price'],
        imageUrl: product['imageUrl'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Text('Shoes\nCollection',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    enabled: false,
                    filled: true,
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search',
                    border: border,
                    enabledBorder: border,
                  ),
                ),
              ),
            ],
          ),
          // 🔹 Filter Chips
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final String eachItem = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = eachItem;
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedFilter == eachItem
                          ? Theme.of(context).colorScheme.primary
                          : chipColor,
                      label: Text(eachItem),
                      side: BorderSide(color: chipColor),
                      labelPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                );
              },
            ),
          ),
          // 🔹 Display Filtered Products
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1080) {
                  // ✅ GridView for large screens
                  return GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      childAspectRatio: 2, // Keeps your original design
                    ),
                    itemBuilder: buildProductCard, // ✅ Uses extracted function
                  );
                } else {
                  // ✅ ListView for smaller screens (Original Design)
                  return ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: buildProductCard, // ✅ Uses extracted function
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
