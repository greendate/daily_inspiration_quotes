#import "DailyInspirationQuotesPlugin.h"
#if __has_include(<daily_inspiration_quotes/daily_inspiration_quotes-Swift.h>)
#import <daily_inspiration_quotes/daily_inspiration_quotes-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "daily_inspiration_quotes-Swift.h"
#endif

@implementation DailyInspirationQuotesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDailyInspirationQuotesPlugin registerWithRegistrar:registrar];
}
@end
