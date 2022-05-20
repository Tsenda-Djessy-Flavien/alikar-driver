import 'package:dio/dio.dart';

class ApiBaseHelper {
  static const String url = 'BASE_URL';
  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
            onRequest: (req,opt)=>requestInterceptor(options: req),
          onError:(DioError e,int)async
          {
            return e.response!.data;
          }
            ),
      );
  }

  static dynamic requestInterceptor({required RequestOptions options}) async {
    // Get your JWT token
    const token = '';
    options.headers.addAll({"Authorization": "Bearer: $token"});
    return options;
  }

  static final dio = createDio();
  static final baseAPI = addInterceptors(dio);

  Future<Response?> getHTTP({required String url}) async
  {
    try {
      Response response = await baseAPI.get(url);
      return response;
    } on DioError catch(e)
    {
      // Handle error
    }
  }

  Future<Response?> postHTTP({required String url,required dynamic data}) async {
    try {
      Response response = await baseAPI.post(url, data: data);
      return response;
    } on DioError catch(e)
    {
      // Handle error
    }
  }

  Future<Response?> putHTTP({required String url,required dynamic data}) async {
    try {
      Response response = await baseAPI.put(url, data: data);
      return response;
    } on DioError catch(e) {
      // Handle error
    }
  }

  Future<Response?> deleteHTTP({required String url}) async {
    try {
      Response response = await baseAPI.delete(url);
      return response;
    } on DioError catch(e) {
      // Handle error
    }
  }
}