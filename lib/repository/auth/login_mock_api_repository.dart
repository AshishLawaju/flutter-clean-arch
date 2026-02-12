
import 'package:clean_coding/models/user/user_model.dart';
import 'package:clean_coding/repository/auth/login_repository.dart';

class LoginMockApiRepository implements LoginRepository{


  //reponse chai modal ma awocha
  @override
  Future<UserModel> loginApi(dynamic data) async {


    await Future.delayed(Duration(seconds: 2));

    final response = {

      "token":"thisistoken"

    };

    return UserModel.fromJson(response);
  }
}
