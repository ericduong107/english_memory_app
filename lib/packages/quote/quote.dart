import 'dart:math';

import 'package:english_memory_app/packages/quote/quote_model.dart';
import 'package:english_memory_app/packages/quote/quotes.dart';

class Quotes {
  static final Quotes _instance = Quotes._internal();
  static List<Quote> datas = [];
  Quotes._internal();

  factory Quotes() => _instance;
  getAll() {
    // datas = await compute(convert, allquotes);
    datas = allquotes.map((e) => Quote.fromJson(e)).toList();
  }

  static List<Quote> convert(List<dynamic> quotes) {
    return quotes.map((e) => Quote.fromJson(e)).toList();
  }

  Quote? getByNoun(String word) {
    List<Quote> quotes = datas.where((element) {
      String content = element.getContent() ?? " ";
      return content.contains(word);
    }).toList();
    Random ran = Random();
    return quotes.isEmpty ? null : quotes[ran.nextInt(quotes.length)];
  }

  int _getRandomIndex() {
    return Random.secure().nextInt(allquotes.length);
  }

  // //Returns first quote

  // static Quote getFirst() {
  //   return new Quote.fromJson(allquotes[0]);
  // }

  // //Returns last quote

  // static Quote getLast() {
  //   return new Quote.fromJson(allquotes[allquotes.length - 1]);
  // }

  // //Returns random quote

  Quote getRandom() {
    return datas[_getRandomIndex()];
  }
}
