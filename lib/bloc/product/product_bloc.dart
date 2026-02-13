import 'package:bloc/bloc.dart';
import 'package:clean_coding/data/response/api_response.dart';
import 'package:clean_coding/models/products/product_model.dart';
import 'package:clean_coding/repository/products/product_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository})
      : super(ProductState(productList: ApiResponse<List<ProductModel>>.loading())) {
    on<ProductEvent>(fetchProductListApi);
  }

  Future<void> fetchProductListApi(
    ProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(productList: ApiResponse<List<ProductModel>>.loading()));
    
    try {
      final productList = await productRepository.fetchProductList();
      emit(state.copyWith(
        productList: ApiResponse<List<ProductModel>>.completed(productList)
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(
        productList: ApiResponse<List<ProductModel>>.error(error.toString())
      ));
    }
  }
}
