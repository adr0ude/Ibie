sealed class Result<T> {
  const Result();

  // cria um [Result] de sucesso com um [value] específico
  const factory Result.ok(T value) = Ok._;

  // cria um [Result] de erro com um [error] específico
  const factory Result.error(Exception error) = Error._;
}

// subclasse de Result para values
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  final T value;
}

// subclasse de Result para errors
final class Error<T> extends Result<T> {
  const Error._(this.error);

  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';

  String get errorMessage {
    final error = (this as Error).error.toString();
    return error.startsWith('Exception: ') ? error.substring(11) : error;
  }
}