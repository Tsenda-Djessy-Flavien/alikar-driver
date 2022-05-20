import 'package:alikardriver/Model/UserModel/UserModel.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio();

  final _baseUrl = 'https://reqres.in/api';


  Future<UserModel?> createUser({required UserModel usermodel}) async {
    UserModel? retrievedUser;

    try {
      Response response = await dio.post(
        'http://192.168.11.120:8088/api/users/signup',
        data: usermodel.toMap(),
      );

      print('User created: ${response.data}');

      retrievedUser = UserModel.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }

}

final DioClient client = DioClient();