import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gnews/models/news_model.dart';

class APIHelper {

  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<List<ResultModel>?> fetchData() async {
    String api = "https://newsdata.io/api/1/latest?apikey=pub_63184fca7ddf1f3660a6a27c2960e6d5bf12f&q=news";

    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {

      String body = res.body;

      Map<String, dynamic> decodedData = jsonDecode(body);
      List allData = decodedData['results'];

      List<ResultModel> allDataMOdel = allData.map((e) => ResultModel.fromJson(e)).toList();
      // ResultModel obj = ResultModel.fromJson(decodedData);

      return allDataMOdel;
    }
    return null;
  }
}