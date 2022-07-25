import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'daily_inspiration_quotes_platform_interface.dart';

/// An implementation of [DailyInspirationQuotesPlatform] that uses method channels.
class MethodChannelDailyInspirationQuotes extends DailyInspirationQuotesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('daily_inspiration_quotes');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
