import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../daily_inspiration_quotes_platform_interface.dart';
import '../models/Quote.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class QuoteLoadingScreen extends StatefulWidget {
  final Color? canvasColor;
  final Color? textColor;

  Future<String?> getPlatformVersion() {
    return DailyInspirationQuotesPlatform.instance.getPlatformVersion();
  }

  QuoteLoadingScreen({
    this.canvasColor,
    this.textColor, 
    Key? key,
  }) : super(key: key);

  @override
  State<QuoteLoadingScreen> createState() {
    return _QuoteLoadingScreenState(
      canvasColor: canvasColor,
      textColor: textColor,
    );
  }
}

class _QuoteLoadingScreenState extends State<QuoteLoadingScreen> {
  List<Quote> _quotesList = [];
  final Color? canvasColor;
  final Color? textColor;

  _QuoteLoadingScreenState({
    required this.textColor,
    this.canvasColor,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchQuotes(),
        builder: (context, snapshot) {
          return quoteWidget(canvasColor, textColor);
        });
  }

  Set<int> shownQuotes = new Set();

  Widget quoteWidget(Color? canvasColor, Color? textColor) {
    
    var rnd = Random();
    var text = "", author = "";

    // Check if the quotes have been loaded successfuly before accessing List elements
    if (_quotesList.isNotEmpty) {
      int index = rnd.nextInt(_quotesList.length - 1);
      text = _quotesList[index].text!;
      author = _quotesList[index].author!;
    }

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      AlertDialog(
          title: Text("${text}",
              style: TextStyle(color: (textColor != null)? textColor: Colors.black45, fontFamily: 'Pacifico')),
          content: Align(
              heightFactor: 1.0,
              widthFactor: 1.0,
              alignment: Alignment.topRight,
              child: Text("${author}",
                  style: TextStyle(fontFamily: 'Pacifico', color: (textColor != null)? textColor: Colors.black45))),
          backgroundColor: (canvasColor != null)? canvasColor: Colors.amber[200],
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.navigate_next),
              color: (textColor != null)? textColor: Colors.black45,
              tooltip: 'Next Quote',
              onPressed: () {
                setState(() {
                  var rnd = Random();
                  int index = rnd.nextInt(_quotesList.length - 1);
                  
                  while(shownQuotes.contains(index)) index = rnd.nextInt(_quotesList.length - 1);
                  // Already displayed indices would be stored in set in order to prevent repetition of same quotes
                  shownQuotes.add(index);
                  
                  text = _quotesList[index].text!;
                  author = _quotesList[index].author!;
                });
              },
            ),
          ]),
      CircularProgressIndicator(
        color: canvasColor,
      )
    ]);
  }

  Future<void> fetchQuotes() async {
    Response response =
        await http.get(Uri.parse('https://type.fit/api/quotes'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      body.forEach((json) {
        _quotesList.add(Quote.fromJson(json));
      });
    }
  }
}
