enum Status { loading, success, failed }

class Resource<T> {
  final Status status;

  final T? data;
  final String? message;
  final Exception? error;

  const Resource({
    required this.status,
    this.data,
    this.error,
    this.message,
  });

  static Resource<T> loading<T>({T? data}) =>
      Resource<T>(data: data, status: Status.loading);

  static Resource<T> failed<T>({required Exception error, T? data}) =>
      Resource<T>(error: error, data: data, status: Status.failed);

  static Resource<T> success<T>({T? data}) =>
      Resource<T>(data: data, status: Status.success);
}
