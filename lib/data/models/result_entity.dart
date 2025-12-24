abstract class ResultEntity<T> {
  const ResultEntity();
}

class SuccessEntity<T> extends ResultEntity<T> {
  final T data;

  SuccessEntity({required this.data});
}

class FailureEntity<T> extends ResultEntity<T> {
  final Exception exception;

  FailureEntity({required this.exception});
}
