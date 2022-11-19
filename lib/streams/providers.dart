import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/datamap.dart';
import '../services/news.dart';
import 'controllers.dart';
import 'enums.dart';

final singleControllersProvider = Provider<SingleControllers>((ref) {
  return SingleControllers.getInstance();
});

final newsProvider = Provider<News>((ref) {
  return News();
});

final sinkControllerProvider = Provider<SinkController>((ref) {
  final controllers = ref.watch(singleControllersProvider);
  final news = ref.watch(newsProvider);
  return SinkController.getInstance(controllers: controllers, news: news);
});

final integerProvider = StateProvider.family<int, IntegerType>((ref, type) {
  switch (type) {
    case IntegerType.bottomNavigation:
      return 0;
    case IntegerType.scrollIdx:
      return 0;
  }
});

final filteredProvider = StreamProvider<List<DataMap>>((ref) async* {
  final SinkController sinkController = ref.watch(sinkControllerProvider);
  final controllers = sinkController.controllers;
  final news = sinkController.news;
  controllers.overseasNews.setState = await news.getGlobal(0);
  yield* sinkController.filteredBySearchValue;
});
