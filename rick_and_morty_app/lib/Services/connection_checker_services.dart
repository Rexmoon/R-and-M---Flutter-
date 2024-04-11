import 'package:internet_connection_checker/internet_connection_checker.dart';

mixin ConnectionCheckerServicesMixin {
  Future<bool> get hasConnection async {
    return await InternetConnectionChecker().hasConnection;
  }
}
