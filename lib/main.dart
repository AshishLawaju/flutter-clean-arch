import 'package:clean_coding/config/routes/routes.dart';
import 'package:clean_coding/config/routes/routes_name.dart';
import 'package:clean_coding/repository/auth/login_http_api_repository.dart';
import 'package:clean_coding/repository/auth/login_mock_api_repository.dart';
import 'package:clean_coding/repository/auth/login_repository.dart';
import 'package:clean_coding/repository/products/product_http_api_repository.dart';
import 'package:clean_coding/repository/products/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


GetIt getIt = GetIt.instance;
void main() {
  serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: SplashScreen()

      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}


//dart run build_runner build
//flutter packages pub run build_runner build --delete-conflicting-outputs



void serviceLocator(){
  getIt.registerLazySingleton<LoginRepository>(()=>LoginHttpApiRepository());
  // getIt.registerLazySingleton<LoginRepository>(()=>LoginMockApiRepository());

  getIt.registerLazySingleton<ProductRepository>(()=>ProductHttpApiRepository());


}