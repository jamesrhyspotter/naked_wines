import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/basket_bloc.dart';
import 'basket_page.dart';
import 'products_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _pageIndex;

  @override
  void initState() {
    super.initState();

    _pageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() => _pageIndex = value),
        currentIndex: _pageIndex,
        items: [
          const BottomNavigationBarItem(
            label: 'Products',
            icon: Icon(Icons.list_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Basket',
            icon: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.shopping_basket_outlined),
                Transform.translate(
                  offset: const Offset(12, -6),
                  child: BlocBuilder<BasketBloc, BasketBlocState>(
                    builder: (context, state) {
                      if (state.loading ||
                          state.failure != null ||
                          state.products.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return SizedBox(
                        width: 18,
                        height: 18,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(state.products.length.toString()),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _pageIndex,
        children: const [
          ProductsPage(),
          BasketPage(),
        ],
      ),
    );
  }
}
