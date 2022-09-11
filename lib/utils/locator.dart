import 'package:get_it/get_it.dart';
import 'package:instagram_clone/pages/timeline/repository/timeline_repository.dart';
import 'package:instagram_clone/pages/timeline/repository/timeline_service.dart';

import '../pages/auth/repository/auth_repository.dart';
import '../pages/auth/repository/auth_service.dart';
import '../pages/profile/repository/profile_repository.dart';
import '../pages/profile/repository/profile_service.dart';
import '../pages/story/repository/story_repository.dart';
import '../pages/story/repository/story_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<TimelineRepository>(() => TimelineRepository());
  locator.registerLazySingleton<TimelineService>(() => TimelineService());
  locator.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
  locator.registerLazySingleton<ProfileService>(() => ProfileService());
  locator.registerLazySingleton<StoryRepository>(() => StoryRepository());
  locator.registerLazySingleton<StoryService>(() => StoryService());
}
