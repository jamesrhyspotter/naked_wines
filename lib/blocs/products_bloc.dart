import 'package:flutter_bloc/flutter_bloc.dart';

import '../entities/product.dart';
import '../services/products_service.dart';

class ProductsBloc extends Bloc<ProductsBlocEvent, ProductsBlocState> {
  ProductsBloc()
      : super(ProductsBlocState(
            products: [],
            failure: null,
            loading: false,
            selectedProduct: null,
            reviews: null,
            loadingProduct: false)) {
    on<ProductsBlocEventFetchProducts>((event, emit) async {
      emit(ProductsBlocState(
          products: state.products,
          failure: null,
          loading: true,
          selectedProduct: state.selectedProduct,
          loadingProduct: false));

      final products = await ProductsService().fetchProducts();

      emit(ProductsBlocState(
          products: products,
          failure: null,
          loading: false,
          selectedProduct: state.selectedProduct,
          loadingProduct: false));
    });

    on<ProductsBlocEventViewProduct>((event, emit) async {
      emit(state.copyWith(loadingProduct: true));

      final productDetails =
          await ProductsService().fetchProduct(id: event.productID);

      final productReviews = await ProductsService()
          .fetchProductReviews(productId: event.productID);

      emit(state.copyWith(
        selectedProduct: productDetails,
        reviews: productReviews,
        loadingProduct: false,
      ));
    });

    on<ProductsBlocEventClearSelected>((event, emit) {
      emit(state.copyWith(selectedProduct: null));
    });
  }
}

abstract class ProductsBlocEvent {}

class ProductsBlocEventFetchProducts extends ProductsBlocEvent {}

class ProductsBlocEventViewProduct extends ProductsBlocEvent {
  final int productID;
  ProductsBlocEventViewProduct({required this.productID});
}

class ProductsBlocEventClearSelected extends ProductsBlocEvent {}

class ProductsBlocState {
  final List<Product> products;
  final Object? failure;
  final bool loading;
  final Product? selectedProduct;
  final bool loadingProduct;
  final List<String>? reviews;

  ProductsBlocState({
    required this.products,
    required this.failure,
    required this.loading,
    required this.loadingProduct,
    this.selectedProduct,
    this.reviews,
  });

  ProductsBlocState copyWith({
    List<Product>? products,
    Object? failure,
    bool? loading,
    Product? selectedProduct,
    List<String>? reviews,
    bool? loadingProduct,
  }) {
    return ProductsBlocState(
        products: products ?? this.products,
        failure: failure ?? this.failure,
        loading: loading ?? this.loading,
        loadingProduct: loadingProduct ?? this.loadingProduct,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        reviews: reviews ?? this.reviews);
  }
}
