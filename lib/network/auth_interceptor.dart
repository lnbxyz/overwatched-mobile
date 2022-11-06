import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/shared_preference_helper.dart';

class AuthInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      var prefs = SharedPreferenceHelper(prefs: await SharedPreferences.getInstance());
      String token = prefs.getUserToken();

      data.headers["Content-Type"] = "application/json";
      data.headers["Authorization"] = "Bearer $token";
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async => data;
}