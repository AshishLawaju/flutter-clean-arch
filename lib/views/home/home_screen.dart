import 'package:clean_coding/bloc/product/product_bloc.dart';
import 'package:clean_coding/config/routes/routes_name.dart';
import 'package:clean_coding/main.dart';
import 'package:clean_coding/repository/products/product_http_api_repository.dart'; // Add this import
import 'package:clean_coding/models/products/product_model.dart';
import 'package:clean_coding/services/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/enums.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleLogout(BuildContext context) async {
    final localStorage = LocalStorage();
    await localStorage.clearValue('token');
    await localStorage.clearValue('isLogin');
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.loginScreen,
        (route) => false,
      );
    }
  }

  Widget _buildProducts(dynamic data) {
    List<ProductModel> products = [];

    // Handle BOTH single ProductModel AND List<ProductModel>
    if (data is ProductModel) {
      products = [data];
    } else if (data is List<dynamic>) {
      products = data
          .map((e) => e as ProductModel)
          .whereType<ProductModel>()
          .toList();
    } else if (data == null) {
      return const Center(child: Text('No products found'));
    }

    if (products.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return ListView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.shopping_bag, color: Colors.blue),
            ),
            title: Text(product.title ?? 'No title'),
            subtitle: Text(product.description ?? ''),
            trailing: Text('\$${product.price ?? 0}'),
          ),
        );
      },
    );
  }

  Widget _buildProductCard(ProductModel? product) {
    if (product == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'No product found',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(Icons.shopping_bag, color: Colors.blue),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      product.title ?? 'No title',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                product.description ?? 'No description',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () => _handleLogout(context),
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocProvider(
        // 🔥 FIXED: Direct instantiation instead of getIt
        create: (context) => ProductBloc(
          productRepository: ProductHttpApiRepository(), // Direct repository
        )..add(ProductFetched()),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return switch (state.productList.status) {
              Status.loading => const Center(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              Status.error => Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.productList.message ?? 'Something went wrong',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () =>
                            context.read<ProductBloc>().add(ProductFetched()),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
              // Status.completed => _buildProductCard(state.productList.data),
              Status.completed => _buildProducts(
                state.productList.data,
              ), // Works with ANY data type!

              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
