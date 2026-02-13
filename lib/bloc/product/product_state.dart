// part of 'product_bloc.dart';

// class ProductState extends Equatable {
//   const ProductState({required this.productList});

//   final ApiResponse<ProductModel> productList;

//   ProductState copyWith({ApiResponse<ProductModel>? productList}) {
//     return ProductState(productList: productList ?? this.productList);
//   }

//   @override
//   List<Object> get props => [productList];
// }

// final class ProductInitial extends ProductState {}


part of 'product_bloc.dart';

class ProductState extends Equatable {
  const ProductState({required this.productList});

  //  FIXED: List<ProductModel> instead of single ProductModel
  final ApiResponse<List<ProductModel>> productList;

  ProductState copyWith({ApiResponse<List<ProductModel>>? productList}) {
    return ProductState(productList: productList ?? this.productList);
  }

  @override
  List<Object> get props => [productList];
}
