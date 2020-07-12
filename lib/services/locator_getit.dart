import 'package:get_it/get_it.dart';
import 'package:mvvmarchitecture_flutter/services/api_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());
}
