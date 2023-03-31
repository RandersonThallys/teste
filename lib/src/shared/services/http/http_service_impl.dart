
import 'package:http/http.dart' as http;

import 'http_service.dart';

class HttpServiceImp implements HttpService {
  @override
  Future get<T>(String url) async {
    var uri = Uri.parse(url);
    var response = await http.get(uri);

    return response;
  }
}