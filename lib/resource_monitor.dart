import 'dart:async';
import 'package:flutter/services.dart';

class ResourceMonitor {
  static const MethodChannel _channel = MethodChannel('resource_monitor');

  static Future<Map> get getResourceUsage async =>
      await _channel.invokeMethod('getResourceUsage');
}
