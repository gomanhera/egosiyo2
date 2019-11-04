import 'package:http/http.dart' as http;
import 'dart:convert';


class MyHttp {
  var defaultHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  Future<Map<String, dynamic>> post({
      String domain,
      String path,
      String method,
      var headers,
      var json,
      Function preExecutor,
      Function postExecutor
    }) async {
    print('domain ::: ' + domain);
    print('path ::: ' + path);
    print('method ::: ' + method);
    print('json ::: ' + json.toString());
    method = method?.toLowerCase();

    Map<String, String> copiedHeaders = new Map.from(this.defaultHeaders);

    headers.forEach((k, v) {
      if (copiedHeaders[k] != null) {
        copiedHeaders[k] = headers[k];
      }
    });
    http.Response response = await http.post(
        Uri.encodeFull('http://' + domain + path),
        headers: copiedHeaders,
        body: json
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    print("### response ###");
    print(data);
    print("##################");
    if (postExecutor != null) {
      data = postExecutor(data);
    }
    return data;
  }
}
////  var response;
////  if(url === 'get'){
////
////  }
//
//// http://example.org/path?q=dart.
////  new Uri.http("example.org", "/path", { "q" : "dart" });
//
//// http://user:pass@localhost:8080
////  new Uri.http("user:pass@localhost:8080", "");
//
//// http://example.org/a%20b
////  new Uri.http("example.org", "a b");
//
//// http://example.org/a%252F
////  new Uri.http("example.org", "/a%2F");
//
////  var uri =
////  Uri.http(url, path, json);
////    response = await http.get(
////      uri,
////      headers: {
////        "Accept": "application/json",
////        "Content-Type": "application/x-www-form-urlencoded",
////      },
////      body: json
////        );
//
//
////  var client = new http.Client();
////  try {
////    var uriResponse = await client.post('http://example.com/whatsit/create',
////    body: json);
////    print(await client.get(uriResponse.bodyFields['uri']));
////  } finally {
////  client.close();
////  }
//    http.Response response = await http.post(
//        Uri.encodeFull('http://115.84.165.224/bigfile/iot/sheet/json/download.do'),
//        headers: headers,
//        body:{
//          "srvType": "S",
//          "infId": "OA-118",
//          "serviceKind": "1",
//          "pageNo": "2",
//          "gridTotalCnt": "127",
//          "ssUserId": "SAMPLE_VIEW",
//          "strWhere": "",
//          "strOrderby": "",
//          "ftr_LINE_NUM": "1",
//          "filterCol": "필터선택",
//          "txtFilter": ""
//        }
//    );
////    print(response.body);
//    Map<String, dynamic> data = jsonDecode(response.body);
//    print("###");
//    print(data);
//    CommonData.setSubwayData(data);
//    CommonData.subwayData = data;
//    return data;
//
//
////  Map<String, String> headerOverwrite(headers){
////    this.defaultHeaders.forEach((k1,v1){
////
////
////      headers.forEach((k2,v2){
////        if(k1 === k2){
////          this.defaultHeaders[k1] = headers[k2];
////        }
////        print('${k}: ${v}');
////      } );
////
////      print('${k}: ${v}');
////    } );
////  }
////  Map mapB = new Map.from(mapA);
//
////  UserAgentClient(this.method, this._inner);
////
////  Future<StreamedResponse> send(BaseRequest request) {
////    request.headers['user-agent'] = userAgent;
////    return _inner.send(request);
////  }
//}
//
//
//Future<Map<String, dynamic>> myRequest(
//    String url,
//    String path,
//    String method,
//    var headers,
//    var json
//    ) async {
//  print('url ::: ' + url);
//  print('path ::: ' + path);
//  print('method ::: ' + method);
//  print('json ::: ' + json);
//  url = url?.toLowerCase();
//
//
////  var response;
////  if(url === 'get'){
////
////  }
//
//// http://example.org/path?q=dart.
////  new Uri.http("example.org", "/path", { "q" : "dart" });
//
//// http://user:pass@localhost:8080
////  new Uri.http("user:pass@localhost:8080", "");
//
//// http://example.org/a%20b
////  new Uri.http("example.org", "a b");
//
//// http://example.org/a%252F
////  new Uri.http("example.org", "/a%2F");
//
////  var uri =
////  Uri.http(url, path, json);
////    response = await http.get(
////      uri,
////      headers: {
////        "Accept": "application/json",
////        "Content-Type": "application/x-www-form-urlencoded",
////      },
////      body: json
////        );
//
//
////  var client = new http.Client();
////  try {
////    var uriResponse = await client.post('http://example.com/whatsit/create',
////    body: json);
////    print(await client.get(uriResponse.bodyFields['uri']));
////  } finally {
////  client.close();
////  }
//  http.Response response = await http.post(
//      Uri.encodeFull('http://115.84.165.224/bigfile/iot/sheet/json/download.do'),
//      headers: headers,
//      body:{
//        "srvType": "S",
//        "infId": "OA-118",
//        "serviceKind": "1",
//        "pageNo": "2",
//        "gridTotalCnt": "127",
//        "ssUserId": "SAMPLE_VIEW",
//        "strWhere": "",
//        "strOrderby": "",
//        "ftr_LINE_NUM": "1",
//        "filterCol": "필터선택",
//        "txtFilter": ""
//      }
//  );
////    print(response.body);
//  Map<String, dynamic> data = jsonDecode(response.body);
//  print("###");
//  print(data);
//  CommonData.setSubwayData(data);
//  CommonData.subwayData = data;
//  return data;
//}
//getData();
