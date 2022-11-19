import 'package:rxdart/rxdart.dart';

import '../base.dart';
import '../models/datamap.dart';
import '../services/news.dart';

class SingleControllers {
  SingleControllers._();
  factory SingleControllers.getInstance() => SingleControllers._();

  final overseasNews = SingleController<List<DataMap>>([]);
  final searchValue = SingleController<String?>(null);
}

class SinkController {
  SinkController._(this.controllers, this.news);

  final SingleControllers controllers;
  final News news;

  factory SinkController.getInstance(
          {required SingleControllers controllers, required News news}) =>
      SinkController._(controllers, news);

  Stream<List<DataMap>> get filteredBySearchValue =>
      CombineLatestStream.combine2(
          controllers.overseasNews.bStream, controllers.searchValue.bStream,
          (a, b) {
        if (b != null && b.isNotEmpty) {
          return a
              .where((element) => (element.title ?? "").contains(b))
              .toList();
        }
        return a;
      });
}
