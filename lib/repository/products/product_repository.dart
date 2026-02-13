
import 'package:clean_coding/models/products/product_model.dart';

abstract class ProductRepository {

  Future<ProductModel> fetchProductList();
}