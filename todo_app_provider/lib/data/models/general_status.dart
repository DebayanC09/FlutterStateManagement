class GeneralStatus<T> {
  Status? status;
  T? data;
  String? message;

  GeneralStatus.idle() : status = Status.idle;

  GeneralStatus.loading() : status = Status.loading;

  GeneralStatus.success({required this.message, required this.data})
      : status = Status.success;

  GeneralStatus.error({required this.message}) : status = Status.error;

  GeneralStatus.validationError() : status = Status.validationError;
}

enum Status { idle, loading, success, error, validationError }
