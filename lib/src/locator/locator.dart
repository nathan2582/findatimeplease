import 'package:findatimeplease/src/globals/app_env.dart';
import 'package:findatimeplease/src/services/logger_service.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/provider_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator(AppEnv env) async {
  locator.registerLazySingleton(() => LoggerService());
  locator.registerLazySingleton(() => ProviderRepository());
}
