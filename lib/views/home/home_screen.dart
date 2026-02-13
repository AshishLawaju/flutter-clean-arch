import 'package:clean_coding/bloc/product/product_bloc.dart';
import 'package:clean_coding/config/routes/routes_name.dart';
import 'package:clean_coding/main.dart';
import 'package:clean_coding/services/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils//enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductBloc productBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productBloc = ProductBloc(productRepository: getIt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              LocalStorage localStorage = LocalStorage();
              localStorage.clearValue('token').then((value) {
                localStorage.clearValue('isLogin').then((value) {
                  Navigator.pushNamed(context, RoutesName.loginScreen);
                });
              });
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      body: BlocProvider(
        create: (_) => productBloc..add(ProductFetched()),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (BuildContext context, state) {
            switch (state.productList.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());

              case Status.error:
                return Center(
                  child: Text(state.productList.message.toString()),
                );

              case Status.completed:

              if(state.productList.data==null){
                return Text("No data found");
              }
              final productList = state.productList.data!;

        print("product list"+ productList.toString());

              return ListView.builder(
                // itemCount: productList,
                itemBuilder: (context,index){
                  

                  // final product = productList[index];


                  return Card(
                    child: ListTile(
                      title: Text(
                        // product.title
                        "sss"
                      ),
                    ),
                  );
                },
              );
                
              case null:
                SizedBox();
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
