


abstract interface class Failure  {
  final String message;
  const Failure(this.message);
}



class SimpleFailure implements Failure {
  final Exception error;

  SimpleFailure({
    required this.error,
  });
  
  @override
  String get message => error.toString();
}







