# Daily Inspiration Quotes

Inspiration quotes are desirable for many tutorial, educational or practicing applications that
require motivated users.

Plugin provides `QuoteDialogButton` and `QuoteLoadingScreen` widgets that provide 1643 different inspiration quotes which are beeing randomly displayed to the user without repetition.

`QuoteDialogButton` on pressed triggers the `ShowDialog` function after which the application displays random quote together with its author.
`QuoteLoadingScreen` could be used in the `LoadingState` of the application. Together with set of quotes application displays a `ProgressIndicator`.

Dialogs and button are customizable, developer is able to set the background and text colors, as well as the desirable `Icon` for the button.

## Demo
![Demo](https://github.com/greendate/daily_inspiration_quotes/blob/main/demo/demo.gif)

## How to use?
- Add the following dependency to `pubspec.yaml` of your project:
```dart
dependencies:
  daily_inspiration_quotes: ^0.0.2
```
- Import `daily_inspiration_quotes.dart` to your code.
```dart
  import 'package:daily_inspiration_quotes/daily_inspiration_quotes.dart';
```
#### QuoteDialogButton
Anywhere in the code you can simply call the function `QuoteDialogButton` and optionally specify following parameters:
- canvasColor,
- textColor,
- buttonIcon,
- buttonColor
- fontFamily
- fontWeight
- and fontStyle
#### QuoteLoadingScreen
Whenewer you have to wait for an asynchronous action to complete and some `LoadingState` displayed to user, instead of just showing `ProgressIndicator` one can return `QuoteLoadingScreen` and optionally specify `canvasColor` and `textColor` of type `Color` and `Font` parameters.
#### Example Code:
```dart
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List"),
      ),
      floatingActionButton: QuoteDialogButton(
        canvasColor: Colors.amber.shade200,
        textColor: Colors.black45,
        buttonIcon: Icons.lightbulb_circle_rounded,
        buttonColor: Colors.amber,
      ),
      body: buildBloc(),
    );
  }
```
## Licence
[MIT Licence](https://github.com/greendate/daily_inspiration_quotes/blob/main/LICENSE)

## Author
Nikola Novarlic
- Edu email : n.novarlic@innopolis.ru
- Telegram : novarlic
