import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

enum NewsType {
  titles(value: "titles"),
  herfs(value: "hrefs"),
  created(value: "created");

  final String value;
  const NewsType({
    required this.value,
  });
}

class News {
  final Dio dio = Dio()
    ..options = BaseOptions(
      baseUrl: "https://www.kita.net",
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );

  Document? document;
  List<List<String?>> titles =
      List.filled(0, [].cast<String?>(), growable: true);
  List<List<String?>> hrefs =
      List.filled(0, [].cast<String?>(), growable: true);
  List<List<String?>> created =
      List.filled(0, [].cast<String?>(), growable: true);
  // maps = {
  // "titles" : [ newList, newList1, ... ]
  // "links" :  [ ..., ... ]
  // }
  Map<String, dynamic> maps = {};

  Future<Map<String, dynamic>> initialize() async {
    titles = [];
    hrefs = [];
    created = [];
    return await getGlobal(0);
  }

  Future<Map<String, dynamic>> getGlobal(int idx) async {
    List<String?> newList = [];
    List<String?> when = [];
    List<String?> aHrefs = [];

    await dio
        .get(
            "/cmmrcInfo/cmmrcNews/overseasMrktNews/overseasMrktNewsList.do?searchOpenYn=&pageIndex=${idx + 1}&nIndex=1&type=&searchReqType=LIST&categorySearch=ALL&searchStartDate=&searchEndDate=&searchCondition=TITLE&searchKeyword=&continent_nm=&continent_cd=&country_nm=&country_cd=&sector_nm=&sector_cd=&itemCd_nm=&itemCd_cd=")
        .then(((res) {
      if (res.statusCode == 200) {
        document = parse(res.data);
        final List<Element>? links = document?.querySelectorAll(".sbj");
        final List<Element>? dates =
            document?.querySelectorAll(".date").sublist(1);

        for (var i = 0; i < ((links?.length) ?? [].length); i++) {
          newList.add(links?[i].innerHtml.toString().trim());
          aHrefs.add(links?[i].attributes["href"]?.trim());
          when.add(dates?[i].innerHtml.toString().trim());
        }
      }
    })).catchError((e) => throw Exception(e));

    if (maps.containsKey(NewsType.titles.value) &&
        maps.containsKey(NewsType.herfs.value) &&
        maps.containsKey(NewsType.created.value)) {
      titles.add(newList);
      hrefs.add(aHrefs);
      created.add(when);

      maps[NewsType.titles.value] = titles;
      maps[NewsType.herfs.value] = hrefs;
      maps[NewsType.created.value] = created;
    } else {
      maps.putIfAbsent(NewsType.titles.value, () {
        titles.add(newList);
        return titles;
      });
      maps.putIfAbsent(NewsType.herfs.value, () {
        hrefs.add(aHrefs);
        return hrefs;
      });
      maps.putIfAbsent(NewsType.created.value, () {
        created.add(when);
        return created;
      });
    }
    return maps;
  }
}
