import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naked_wines_flutter_technical_test/blocs/basket_bloc.dart';
import 'package:naked_wines_flutter_technical_test/entities/product.dart';

import '../blocs/products_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  final int productID;
  const ProductDetailPage({Key? key, required this.productID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsBlocState>(
      builder: (context, state) {
        // Find the selected product from the state using the productId
        final Product? selectedProduct = state.selectedProduct;

        if (state.loadingProduct) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        if (state.failure != null) {
          return Center(
            child: Text(state.failure.toString()),
          );
        }
        switch (selectedProduct == null) {
          case true:
            return const SizedBox(
              child: Text('Couldn\'t get product'),
            );
          case false:
            return Scaffold(
              appBar: AppBar(
                title: Text(selectedProduct!.name),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    BlocProvider.of<ProductsBloc>(context)
                        .add(ProductsBlocEventClearSelected());
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Image(
                    image: NetworkImage(selectedProduct.productImageUrl),
                  ),
                  Text(selectedProduct.name),
                  const SizedBox(height: 12),
                  Text('£${selectedProduct.price / 100}'),
                  BlocBuilder<BasketBloc, BasketBlocState>(
                    builder: ((context, state) {
                      int count = BlocProvider.of<BasketBloc>(context)
                          .state
                          .products
                          .where((product) => productID == product.id)
                          .toList()
                          .length;
                      return MaterialButton(
                        color: selectedProduct.inStock ?? false
                            ? Colors.blue
                            : Colors.red,
                        child: count > 0
                            ? Text('Added ($count)')
                            : selectedProduct.inStock ?? false
                                ? const Text('Add to basket')
                                : const Text('Out of stock! :('),
                        onPressed: () {
                          // ADD PRODUCT TO BASKET (ADD LOGIC HERE)

                          if (selectedProduct.inStock ?? false) {
                            BlocProvider.of<BasketBloc>(context).add(
                                BasketBlocEventAddProductToBasket(
                                    id: productID));
                            showCupertinoDialog(
                                context: context,
                                builder: ((context) => AlertDialog(
                                      title: const Text('Added to Basket:'),
                                      content: Text(selectedProduct.name),
                                      actions: [
                                        TextButton(
                                          child: Text('Dimiss'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    )));
                          } else {
                            showCupertinoDialog(
                                context: context,
                                builder: ((context) => AlertDialog(
                                      title: const Text('Oops! Out of stock'),
                                      content: Text(selectedProduct.name),
                                      actions: [
                                        TextButton(
                                          child: Text('Okay'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    )));
                          }
                        },
                      );
                    }),
                  ),
                  const Text("Description"),
                  Text(selectedProduct.description!),
                  const SizedBox(height: 12),
                  const Text("Reviews"),
                  const SizedBox(height: 12),
                  ...state.reviews!.map((r) => Text(r)).toList()
                  // Add review widgets based on selectedProduct.reviews
                ],
              ),
            );
        }
        return const SizedBox(
          child: Text('Oops something went wrong'),
        );
      },
    );
  }
}
