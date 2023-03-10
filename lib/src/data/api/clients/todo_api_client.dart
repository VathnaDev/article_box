import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/todo.dart';

part 'todo_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class TodoApiClient {
  factory TodoApiClient(Dio dio, {String baseUrl}) = _TodoApiClient;

  @GET('/todos')
  Future<List<Todo>> getTodos();

  @GET('/todos/{id}')
  Future<Todo> getTodo(@Path('id') int id);
}
