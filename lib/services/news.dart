import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

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
  // maps = {
  // "titles" : [ newList, newList1, ... ]
  // "links" :  [ ..., ... ]
  // }
  Map<String, dynamic> maps = {};

  Future<Map<String, dynamic>> getGlobal(int idx) async {
    List<String?> newList = [];
    List<String?> aHrefs = [];

    await dio
        .get(
            "/cmmrcInfo/cmmrcNews/overseasMrktNews/overseasMrktNewsList.do?searchOpenYn=&pageIndex=${idx + 1}&nIndex=1&type=&searchReqType=LIST&categorySearch=ALL&searchStartDate=&searchEndDate=&searchCondition=TITLE&searchKeyword=&continent_nm=&continent_cd=&country_nm=&country_cd=&sector_nm=&sector_cd=&itemCd_nm=&itemCd_cd=")
        .then(((res) {
      if (res.statusCode == 200) {
        document = parse(res.data);
        final List<Element>? links = document?.querySelectorAll(".sbj");

        for (Element link in links ?? []) {
          newList.add(link.innerHtml.trim());
          aHrefs.add(link.attributes["href"]?.trim());
        }
      }
    })).catchError((e) => throw Exception(e));

    if (maps.containsKey("titles") && maps.containsKey("hrefs")) {
      titles.add(newList);
      hrefs.add(aHrefs);
      maps['titles'] = titles;
      maps['hrefs'] = aHrefs;
    } else {
      maps.putIfAbsent("titles", () {
        titles.add(newList);
        return titles;
      });
      maps.putIfAbsent("hrefs", () {
        hrefs.add(aHrefs);
        return hrefs;
      });
    }
    return maps;
  }
}
