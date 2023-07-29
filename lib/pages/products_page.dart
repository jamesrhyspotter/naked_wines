import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/products_bloc.dart';
import 'product_detail_page.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsBlocState>(
      builder: (context, state) {
        if (state.loading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (state.failure != null) {
          return Center(
            child: Text(state.failure.toString()),
          );
        }

        return ListView.builder(
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            final product = state.products[index];

            return ListTile(
              leading: Image(
                image: NetworkImage(product.productImageUrl),
                width: 40,
                height: 40,
              ),
              title: Text(product.name),
              subtitle: Text('£${product.price / 100}'),
              onTap: () async {
                // Dispatch the ProductsBlocEventViewProduct with the selected product's ID
                BlocProvider.of<ProductsBloc>(context)
                    .add(ProductsBlocEventViewProduct(productID: product.id));

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      productID: product.id,
                    ),
                  ),
                );

                // Navigate to the ProductDetailPage when a product is tapped
              },
            );
          },
        );
      },
    );
  }
}
