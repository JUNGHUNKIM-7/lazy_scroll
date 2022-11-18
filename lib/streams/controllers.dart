import '../base.dart';
import '../services/news.dart';

class SingleControllers {
  SingleControllers._();
  factory SingleControllers.getInstance() => SingleControllers._();

  final overseasNews = SingleController<Map<String, List<List<String?>>>>({});
}

class SinkController {
  SinkController._(this.controllers, this.news);

  final SingleControllers controllers;
  final News news;

  factory SinkController.getInstance(
          {required SingleControllers controllers, required News news}) =>
      SinkController._(controllers, news);
}
