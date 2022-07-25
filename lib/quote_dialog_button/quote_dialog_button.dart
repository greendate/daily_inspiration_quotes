import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../daily_inspiration_quotes_platform_interface.dart';
import '../models/Quote.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class QuoteDialogButton extends StatefulWidget {
  Future<String?> getPlatformVersion() {
    return DailyInspirationQuotesPlatform.instance.getPlatformVersion();
  }

  Color? canvasColor;
  Color? textColor;
  IconData? buttonIcon;
  Color? buttonColor;

  QuoteDialogButton( {
    this.canvasColor,
    this.textColor,
    this.buttonIcon,
    this.buttonColor, 
    Key? key,
  }) : super(key: key);

  @override
  State<QuoteDialogButton> createState() {
    return _QuoteDialogButtonState(
      canvasColor: canvasColor,
      textColor: textColor,
      buttonIcon: buttonIcon,
      buttonColor: buttonColor,
    );
  }
}

class _QuoteDialogButtonState extends State<QuoteDialogButton> {
  List<Quote> _quotesList = [];
  final Color? canvasColor;
  final Color? textColor;
  final IconData? buttonIcon;
  final Color? buttonColor;

  _QuoteDialogButtonState({
    required this.textColor,
    this.canvasColor,
    this.buttonIcon,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    // Calling fetchQuotes to request Quotes texts and authors
    return FutureBuilder(
        future: fetchQuotes(),
        builder: (context, snapshot) {
          return quoteButton();
        });
  }

  // Returns a Dialog with random quote
  Widget quoteButton() {
    return TextButton(
        onPressed: () => getQuotes(context),
        child: Icon(
          (buttonIcon != null)? buttonIcon: Icons.lightbulb_circle_rounded,
          color: (buttonColor != null)? buttonColor: Colors.amber,
          size: 50,
        ));
  }
  Set<int> shownQuotes = new Set();

  Future<Future<String?>> getQuotes(BuildContext context) async {
    // Taking random index of the quotesList
    var rnd = Random();
    int index = rnd.nextInt(_quotesList.length - 1);
    while(shownQuotes.contains(index)) index = rnd.nextInt(_quotesList.length - 1);

    // Already displayed indices would be stored in set in order to prevent repetition of same quotes
    shownQuotes.add(index);

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("${_quotesList[index].text}",
            style: TextStyle(color: (textColor != null)? textColor: Colors.black45, fontFamily: 'Pacifico')),
        content: Align(
            heightFactor: 1.0,
            widthFactor: 1.0,
            alignment: Alignment.topRight,
            child: Text("${_quotesList[index].author}",
                style: TextStyle(fontFamily: 'Pacifico', color: (textColor != null)? textColor: Colors.black45))),
        backgroundColor: (canvasColor != null)? canvasColor: Colors.amber[200],
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text('Close',
                style: TextStyle(
                  color: (textColor != null)? textColor: Colors.black45,
                )),
          ),
        ],
      ),
    );
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
