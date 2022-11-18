import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'component/global/global_component.dart';
import 'streams/enums.dart';
import 'streams/providers.dart';

class App extends ConsumerWidget {
  const App({super.key});

  static const List bottomItems = [
    [Icons.abc, "Home"],
    [Icons.add, "Home2"]
  ];

  static final bodies = <Widget>[
    const Home(),
    const Home2(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idx = ref.watch(integerProvider(IntegerType.bottomNavigation));
    return Scaffold(
      backgroundColor: const Color(0xFFe5e5e5),
      extendBody: true,
      bottomNavigationBar:
          MainBottomNavigation(idx: idx, bottomItems: bottomItems),
      body: bodies.elementAt(idx),
    );
  }
}

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late ScrollController _sc;

  @override
  void initState() {
    super.initState();
    _sc = ScrollController()
      ..addListener(() async {
        if (_sc.position.atEdge) {
          if (_sc.position.pixels >= _sc.position.maxScrollExtent ~/ 2) {
            await _onRefresh(ref);
          }
        }
      });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overseasMarket$ = ref.watch(initialOverSeasNewsStream);

    return RefreshIndicator(
      onRefresh: () async => _onInit(ref),
      child: ListView(
        controller: _sc,
        children: [
          overseasMarket$.when(
            error: (err, stk) => Text('$err $stk'),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (Map<String, List<List<String?>>> m) {
              log("${overseasMarket$.value}");
              final titles = m["titles"];
              final hrefs = m["hrefs"];
              final created = m["created"];

              if (titles != null && hrefs != null && created != null) {
                return ListView(
                  primary: false,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    for (var i = 0; i < titles.length; i++)
                      for (var j = 0; j < titles[i].length; j++)
                        Column(
                          children: [
                            DataTile(
                              header: titles[i][j] ?? "",
                              url: hrefs[i][j] ?? "",
                              created: created[i][j] ?? "",
                            ),
                            const Divider(thickness: 1),
                          ],
                        )
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onInit(WidgetRef ref) async {
    final sinkController = ref.watch(sinkControllerProvider);
    final data = await sinkController.news.initialize();
    sinkController.controllers.overseasNews.setState = data;
  }

  Future<void> _onRefresh(WidgetRef ref) async {
    //sync scroll count + fetching data(pagination)
    ref.read(integerProvider(IntegerType.scrollIdx).notifier).state =
        ref.watch(integerProvider(IntegerType.scrollIdx)) + 1;
    final sinkController = ref.watch(sinkControllerProvider);
    final data = await sinkController.news
        .getGlobal(ref.watch(integerProvider(IntegerType.scrollIdx)));
    sinkController.controllers.overseasNews.setState = data;
  }
}

class DataTile extends ConsumerWidget {
  const DataTile({
    super.key,
    required this.header,
    required this.url,
    required this.created,
  });

  final String header;
  final String url;
  final String created;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _launch(url),
      child: ListTile(
        title: Text(header),
        trailing: Text(created),
      ),
    );
  }

  Future<void> _launch(String url) async {
    assert(url.isNotEmpty);
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    } else {
      throw Exception("url is empty");
    }
  }
}

class Home2 extends StatelessWidget {
  const Home2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Center(child: Text("home2")),
      ],
    );
  }
}
