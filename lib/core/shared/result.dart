import '../error_handling/app_error.dart';

sealed class Result<T> {
  const Result();

  factory Result.success(T data) = Success<T>;
  factory Result.failure(AppError error) = Failure<T>;

  T get data =>
      this is Success<T> ? (this as Success<T>).data : throw Exception('Result is not a success');
  AppError get error =>
      this is Failure<T> ? (this as Failure<T>).error : throw Exception('Result is not a failure');

  void when({required Function(T data) onSuccess, required Function(AppError error) onFailure}) {
    if (this is Success<T>) {
      onSuccess(data);
    } else {
      onFailure(error);
    }
  }
}

class Success<T> extends Result<T> {
  @override
  final T data;
  const Success(this.data);

  @override
  String toString() {
    return 'Success(data: $data)';
  }
}

class Failure<T> extends Result<T> {
  @override
  final AppError error;
  const Failure(this.error);

  @override
  String toString() {
    return 'Failure(error: $error)';
  }
}
