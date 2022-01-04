import 'dart:async';
import 'package:flutter/services.dart';
import 'models/resource.dart';
export 'models/resource.dart';

class ResourceMonitor {
  static const MethodChannel _channel = MethodChannel('resource_monitor');

  static Future<Resource> get getResourceUsage async =>
      Resource.fromMap(await _channel.invokeMethod('getResourceUsage'));
}
