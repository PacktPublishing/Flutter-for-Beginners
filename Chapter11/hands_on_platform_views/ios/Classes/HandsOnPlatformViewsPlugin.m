#import "HandsOnPlatformViewsPlugin.h"
#import <hands_on_platform_views/hands_on_platform_views-Swift.h>

@implementation HandsOnPlatformViewsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHandsOnPlatformViewsPlugin registerWithRegistrar:registrar];
}
@end
