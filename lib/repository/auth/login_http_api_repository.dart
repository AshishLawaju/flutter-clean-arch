import 'package:clean_coding/config/app_url.dart';
import 'package:clean_coding/data/network/network_services_api.dart';
import 'package:clean_coding/models/user/user_model.dart';
import 'package:clean_coding/repository/auth/login_repository.dart';

class LoginHttpApiRepository implements LoginRepository{
  final _api = NetworkServicesApi();

  //reponse chai modal ma awocha

  @override
  Future<UserModel> loginApi(dynamic data) async {
    final response = await _api.postApi(AppUrl.loginApi, data);

    return UserModel.fromJson(response);
  }
}
