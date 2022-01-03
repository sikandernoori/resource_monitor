#import "ResourceMonitorPlugin.h"
#if __has_include(<resource_monitor/resource_monitor-Swift.h>)
#import <resource_monitor/resource_monitor-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "resource_monitor-Swift.h"
#endif

@implementation ResourceMonitorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftResourceMonitorPlugin registerWithRegistrar:registrar];
}
@end
