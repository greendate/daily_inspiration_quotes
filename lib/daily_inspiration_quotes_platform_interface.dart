import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'daily_inspiration_quotes_method_channel.dart';

abstract class DailyInspirationQuotesPlatform extends PlatformInterface {
  /// Constructs a DailyInspirationQuotesPlatform.
  DailyInspirationQuotesPlatform() : super(token: _token);

  static final Object _token = Object();

  static DailyInspirationQuotesPlatform _instance = MethodChannelDailyInspirationQuotes();

  /// The default instance of [DailyInspirationQuotesPlatform] to use.
  ///
  /// Defaults to [MethodChannelDailyInspirationQuotes].
  static DailyInspirationQuotesPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DailyInspirationQuotesPlatform] when
  /// they register themselves.
  static set instance(DailyInspirationQuotesPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
