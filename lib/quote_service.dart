import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:to_do_getx/models/quote.model.dart';

class QuoteService{
  final category = 'success';
  static const String api_key = "";
  static const String api = 'https://api.quotable.io/random';
  Future<Quote> getQuote() async {
    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      return Quote.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load quote');
    }
  }
}