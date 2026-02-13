import 'package:clean_coding/models/products/product_model.dart';

abstract class ProductRepository {
  // Change from ProductModel to List<ProductModel>
  Future<List<ProductModel>> fetchProductList();
}