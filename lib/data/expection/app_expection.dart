class AppException implements Exception {
  final String? message;
  final String? prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return '${prefix ?? ''}${message ?? 'Unknown error'}';
  }
}



class NoInternetException extends AppException {
    NoInternetException([String? message]) : super(message , 'No internet connection.');
}



class UnAuthorizedException extends AppException {
    UnAuthorizedException([String? message]) : super(message , 'You dont have access to this.');
}


class RequestTimeOutException extends AppException {
    RequestTimeOutException([String? message]) : super(message , 'Request Time out.');
}



class FetchDataException extends AppException {
    FetchDataException([String? message]) : super(message , 'fetch data exp.');
}





