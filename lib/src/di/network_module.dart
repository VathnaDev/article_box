import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/api/clients/todo_api_client.dart';
import '../data/api/dio_utils.dart';
import '../util/logging_interceptor.dart';

final _dioClient = DioUtils.getClient(
  url: "https://jsonplaceholder.typicode.com",
  interceptors: [
    if (kDebugMode) LoggingInterceptor(),
  ],
);

final _todoApiCLientProvider = RepositoryProvider<TodoApiClient>(
  create: (_) => TodoApiClient(_dioClient),
);

final networkProviders = [
  _todoApiCLientProvider,
];
