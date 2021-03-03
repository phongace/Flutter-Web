import 'package:get_it/get_it.dart';
import 'package:time_store/plugin/navigator.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}
