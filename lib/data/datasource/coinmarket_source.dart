import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinMarketSource {

  Future<Map<String, dynamic>> getCoins(String uri) async{

    final response = await http.get(Uri.parse(uri), headers: {"X-CMC_PRO_API_KEY":"5a5924e5-19f5-4843-adf0-df1a163dc85b"});
    final data = jsonDecode(response.body)['data'] as Map<String, dynamic>;
    return data;
  }
}