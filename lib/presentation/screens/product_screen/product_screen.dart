import 'package:e_commerce_store/application/provider/product_provider.dart';
import 'package:e_commerce_store/application/provider/settings_provider.dart';
import 'package:e_commerce_store/presentation/screens/product_screen/ui/delete_product_widget.dart';
import 'package:e_commerce_store/presentation/screens/product_screen/ui/price_and_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<ProductScreen> {
  @override
  void initState() {
    ref.read(productProvider).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider).products;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(settingsProvider).toggleThemeMode();
            },
            icon: Icon(
              ref.watch(settingsProvider).isDarkMode
                  ? Icons.brightness_7
                  : Icons.brightness_4,
            ),
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return DeleteProductWidget(
                  delkey: Key(product.id.toString()),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              product.thumbnail,
                              width:
                                  screenWidth * 0.9, // Responsive image width
                              height:
                                  screenWidth * 0.5, // Responsive image height
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          PriceAndRatingWidget(product: product),
                          SizedBox(
                            width: screenWidth * 0.9, // Responsive text width
                            child: Text(
                              product.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.9, // Responsive text width
                            child: Text(
                              product.description,
                              // You might want to wrap this with an Expanded or Flexible widget if it needs to overflow
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}