import 'package:clean_coding/config/app_url.dart';
import 'package:clean_coding/data/network/network_services_api.dart';
import 'package:clean_coding/models/user/user_model.dart';

abstract class LoginRepository {
 


@override
Future<UserModel> loginApi(dynamic data);
  //reponse chai modal ma awocha
  // Future<UserModel> loginApi(dynamic data) async {
  //   final response = await _api.postApi(AppUrl.loginApi, data);

  //   return UserModel.fromJson(response);
  // }
}
