import 'package:flutter_test/flutter_test.dart';
import 'package:daily_inspiration_quotes/daily_inspiration_quotes.dart';
import 'package:daily_inspiration_quotes/daily_inspiration_quotes_platform_interface.dart';
import 'package:daily_inspiration_quotes/daily_inspiration_quotes_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDailyInspirationQuotesPlatform 
    with MockPlatformInterfaceMixin
    implements DailyInspirationQuotesPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DailyInspirationQuotesPlatform initialPlatform = DailyInspirationQuotesPlatform.instance;

  test('$MethodChannelDailyInspirationQuotes is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDailyInspirationQuotes>());
  });

  test('getPlatformVersion', () async {
    /*
    DailyInspirationQuotes dailyInspirationQuotesPlugin = DailyInspirationQuotes();
    MockDailyInspirationQuotesPlatform fakePlatform = MockDailyInspirationQuotesPlatform();
    DailyInspirationQuotesPlatform.instance = fakePlatform;
  
    expect(await dailyInspirationQuotesPlugin.getPlatformVersion(), '42');
    */
  });
}
