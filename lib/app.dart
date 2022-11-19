import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'component/global/global_component.dart';
import 'models/datamap.dart';
import 'streams/enums.dart';
import 'streams/providers.dart';

class App extends ConsumerWidget {
  const App({super.key});

  static const List bottomItems = [
    [Icons.home, "Home"],
    [Icons.info_rounded, "Home2"]
  ];

  static final bodies = <Widget>[
    const Home(),
    const Home2(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idx = ref.watch(integerProvider(IntegerType.bottomNavigation));
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarSpace(),
        backgroundColor: Colors.grey[300],
      ),
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
    final overseasMarket$ = ref.watch(filteredProvider);
    return RefreshIndicator(
      onRefresh: () async => _onInit(ref),
      child: ListView(
        controller: _sc,
        children: [
          overseasMarket$.when(
            error: (err, stk) => Text('$err $stk'),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (List<DataMap> l$) {
              return ListView.builder(
                itemCount: l$.length,
                itemBuilder: (context, index) {
                  final e = l$[index];
                  return Column(
                    children: [
                      DataTile(
                        header: e.title ?? "",
                        url: e.href ?? "",
                        created: e.created ?? "",
                      ),
                      const Divider(thickness: 1),
                    ],
                  );
                },
                primary: false,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
              );
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
    ref.read(integerProvider(IntegerType.scrollIdx).notifier).state =
        ref.watch(integerProvider(IntegerType.scrollIdx)) + 1;
    final sinkController = ref.watch(sinkControllerProvider);
    final data = await sinkController.news
        .onRefresh(ref.watch(integerProvider(IntegerType.scrollIdx)));
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
    const testUrl = "https://www.kita.net/cmmrcInfo/cmmrcNews/overseasMrktNews/overseasMrktNewsDetail.do?searchOpenYn=&pageIndex=1&nIndex=1828557&type=0&searchReqType=detail&categorySearch=ALL&searchStartDate=&searchEndDate=&searchCondition=TITLE&searchKeyword=&continent_nm=&continent_cd=&country_nm=&country_cd=&sector_nm=&sector_cd=&itemCd_nm=&itemCd_cd=";
    return GestureDetector(
      onTap: () => _launch(testUrl),
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
