#import "HandsOnPlatformVersionPlugin.h"
#import <hands_on_platform_version/hands_on_platform_version-Swift.h>

@implementation HandsOnPlatformVersionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHandsOnPlatformVersionPlugin registerWithRegistrar:registrar];
}
@end
