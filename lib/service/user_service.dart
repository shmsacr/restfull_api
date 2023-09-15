import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restfull_api/model/user_model.dart';

class UserService {
  final String url = "https://reqres.in/api/users?page=2";
  Future<UsersModel?> fetchUsers() async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var jsonBody = UsersModel.fromJson(jsonDecode(res.body));
      return jsonBody;
    } else {
      print("İstek başarısız oldu =>${res.statusCode}");
    }
  }
}
