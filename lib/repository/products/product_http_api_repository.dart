import 'package:clean_coding/config/app_url.dart';
import 'package:clean_coding/data/network/network_services_api.dart';
import 'package:clean_coding/models/products/product_model.dart';
import 'package:clean_coding/repository/products/product_repository.dart';

class ProductHttpApiRepository implements ProductRepository {
  final _api = NetworkServicesApi();

  @override
  Future<List<ProductModel>> fetchProductList() async { // Changed to List
    final response = await _api.getApi(AppUrl.product);

    // Use string interpolation for safer logging
    print("product repo: $response");

    // If response is a List, map it to your model
    return (response as List)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

// bad state: tried to read a provider that threw
// during the creation of type ProdcutBLoc


// typeerror Instance of JSArray<dynamic> : type 'List<dynamic>' is not a subtype of type 'string'