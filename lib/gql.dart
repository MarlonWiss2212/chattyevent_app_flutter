import '../injection.dart' as di;

Future<void> resetDiWithNewGraphQlLink(String token) async {
  await di.serviceLocator.reset();
  await di.init(token: token);
}
