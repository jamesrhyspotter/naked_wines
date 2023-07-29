import 'package:flutter_bloc/flutter_bloc.dart';

import '../entities/product.dart';
import '../services/products_service.dart';

class BasketBloc extends Bloc<BasketBlocEvent, BasketBlocState> {
  BasketBloc()
      : super(BasketBlocState(
          products: [],
          failure: null,
          loading: false,
        )) {
    on<BasketBlocEventFetchBasket>((event, emit) async {
      emit(BasketBlocState(
        products: state.products,
        failure: null,
        loading: true,
      ));

      emit(BasketBlocState(
        products: state.products,
        failure: null,
        loading: false,
      ));
    });

    on<BasketBlocEventAddProductToBasket>((event, emit) async {
      emit(BasketBlocState(
        products: state.products,
        failure: null,
        loading: true,
      ));

      final product = await ProductsService().fetchProduct(id: event.id);

      final products = [...state.products, product];

      emit(BasketBlocState(
        products: products,
        failure: null,
        loading: false,
      ));
    });
  }
}

abstract class BasketBlocEvent {}

class BasketBlocEventFetchBasket extends BasketBlocEvent {}

class BasketBlocEventAddProductToBasket extends BasketBlocEvent {
  final int id;

  BasketBlocEventAddProductToBasket({
    required this.id,
  });
}

class BasketBlocState {
  final List<Product> products;
  final Object? failure;
  final bool loading;

  BasketBlocState({
    required this.products,
    required this.failure,
    required this.loading,
  });
}
