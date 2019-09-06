#import "HandsOnBackgroundProcessPlugin.h"
#import <hands_on_background_process/hands_on_background_process-Swift.h>

@implementation HandsOnBackgroundProcessPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHandsOnBackgroundProcessPlugin registerWithRegistrar:registrar];
}
@end
