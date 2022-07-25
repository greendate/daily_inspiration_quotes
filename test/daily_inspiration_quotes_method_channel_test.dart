import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:daily_inspiration_quotes/daily_inspiration_quotes_method_channel.dart';

void main() {
  MethodChannelDailyInspirationQuotes platform = MethodChannelDailyInspirationQuotes();
  const MethodChannel channel = MethodChannel('daily_inspiration_quotes');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
