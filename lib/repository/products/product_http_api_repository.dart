


import 'package:clean_coding/config/app_url.dart';
import 'package:clean_coding/data/network/network_services_api.dart';
import 'package:clean_coding/models/products/product_model.dart';
import 'package:clean_coding/repository/products/product_repository.dart';

class ProductHttpApiRepository implements ProductRepository{
  final _api = NetworkServicesApi();



  @override
  Future<ProductModel> fetchProductList() async{
      final response = await  _api.getApi(AppUrl.product);   
      return ProductModel.fromJson(response);
  }
}