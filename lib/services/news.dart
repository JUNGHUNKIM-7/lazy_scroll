import 'package:dio/dio.dart';
import 'package:flutter_news/models/datamap.dart';
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

  final List<DataMap> datas = List<DataMap>.empty(growable: true);

  Future<List<DataMap>> getGlobal(int idx) async {
    final newList = List<String?>.empty(growable: true);
    final when = List<String?>.empty(growable: true);
    final aHrefs = List<String?>.empty(growable: true);

    await dio
        .get(
            "/cmmrcInfo/cmmrcNews/overseasMrktNews/overseasMrktNewsList.do?searchOpenYn=&pageIndex=${idx + 1}&nIndex=1&type=&searchReqType=LIST&categorySearch=ALL&searchStartDate=&searchEndDate=&searchCondition=TITLE&searchKeyword=&continent_nm=&continent_cd=&country_nm=&country_cd=&sector_nm=&sector_cd=&itemCd_nm=&itemCd_cd=")
        .then(((res) {
      if (res.statusCode == 200) {
        document = parse(res.data);
        if (document != null) {
          final List<Element?> links = document!.querySelectorAll(".sbj");
          final List<Element?> dates =
              document!.querySelectorAll(".date").sublist(1);

          for (var i = 0; i < links.length; i++) {
            newList.add(links[i]?.innerHtml.toString().trim());
            aHrefs.add(links[i]?.attributes["href"]?.toString().trim());
            when.add(dates[i]?.innerHtml.toString().trim());
          }
        } else {
          throw Exception("document is null");
        }
      }
    })).catchError((e) => throw Exception(e));

    if (newList.length != aHrefs.length ||
        newList.length != when.length ||
        aHrefs.length != when.length) {
      throw Exception("len isn't matched");
    }

    final List<List<String?>> dataList = [newList, aHrefs, when];

    final mapped = [
      for (var i = 0; i < dataList[1].length; i++)
        DataMap(
            title: dataList.first[i] ?? "",
            href: dataList[1][i] ?? "",
            created: dataList.last[i] ?? "")
    ];

    if (idx == 0) {
      //initialize
      datas.addAll(mapped);
    }

    // [DataMap(title, ..), Datamap(title,. ..) ..]
    return mapped;
  }

  Future<List<DataMap>> initialize() async {
    return await getGlobal(0);
  }

  Future<List<DataMap>> onRefresh(int idx) async {
    final newDatas = await getGlobal(idx);
    datas.addAll(newDatas);
    return datas;
  }
}
