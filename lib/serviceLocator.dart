import 'package:get_it/get_it.dart';
import 'package:jessic_flutter/MusicService.dart';

class ServiceLocator {
  // static GetIt getIt = GetIt.instance;
  static setupLocator() {
    GetIt.instance
        .registerSingleton<MusicServiceModel>(MusicServiceImplementation());
  }
}
