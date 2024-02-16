// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mvvm_auth2/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;
  ApiResponse({
    this.status,
    this.data,
    this.message,
  });

  // Named Constructors like :status
  // api loading status
  ApiResponse.loading() : status = Status.Loading;
  // api complete status message
  ApiResponse.completed(data) : status = Status.Completed;
  // api error status message
  ApiResponse.error(message) : status = Status.Error;

  @override
  String toString() {
    return "status : $status \n Message : $message \n Data : $data";
  }
}
