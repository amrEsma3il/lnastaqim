import 'package:freezed_annotation/freezed_annotation.dart';
import '../errors/network_exceptions.dart';

part 'api_result.freezed.dart';

@freezed
abstract class DataState<T> with _$DataState<T> {
  const factory DataState.success(T data) = Success<T>;

  const factory DataState.failure(NetworkExceptions networkExceptions) =
      Failure<T>;
}

