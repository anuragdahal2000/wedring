import 'package:dio/dio.dart';

final options = BaseOptions(
  baseUrl: 'http://localhost:3000/v1',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
);

final api = Dio(options);
