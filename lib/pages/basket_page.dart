import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/basket_bloc.dart';
import 'product_detail_page.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BasketBloc, BasketBlocState>(
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
                  height: 40,
                  width: 40,
                ),
                title: Text(product.name),
                subtitle: Text('£${product.price / 100}'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      productID: product.id,
                    ),
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
