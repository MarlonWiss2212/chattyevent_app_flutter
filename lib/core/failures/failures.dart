abstract class Failure {}

class ServerFailure extends Failure {}

class GeneralFailure extends Failure {}

class CacheFailure extends Failure {}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return "Ups, API Error. Please try again";
    case GeneralFailure:
      return "Ups, Something went wrong. Please try again";
    case CacheFailure:
      return "Ups, Caching Error, Please try again";
    default:
      return "Ups, Something went wrong. Please try again";
  }
}
