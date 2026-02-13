import 'package:bloc/bloc.dart';
import 'package:clean_coding/data/response/api_response.dart';
import 'package:clean_coding/models/products/product_model.dart';
import 'package:clean_coding/repository/products/product_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {


  //last ma
  ProductRepository productRepository;




  ProductBloc({required this.productRepository}) : super(ProductState(productList: ApiResponse.loading())) {
    // on<ProductEvent>((event, emit) {
    //   // TODO: implement event handler
    // });


    on<ProductEvent>(fetchProductListApi);
  }


  Future <void> fetchProductListApi (ProductEvent event , Emitter<ProductState> emit)async{

      await productRepository.fetchProductList().then((value){

          emit(state.copyWith(productList: ApiResponse.completed(value)));

      }).onError((error,stackTrace){

   emit(state.copyWith(productList: ApiResponse.error(error.toString())));

      });


  }
}
