import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:resource_monitor/resource_monitor.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Resource? _data;
  static const double _defaultValue = 0.0;
  double _appCpuUsagePeak = _defaultValue, _appMemoryUsagePeak = _defaultValue;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _getResource());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> _getResource() async {
    try {
      final data = await ResourceMonitor.getResourceUsage;

      _appCpuUsagePeak = data.cpuInUseByApp > _appCpuUsagePeak
          ? data.cpuInUseByApp
          : _appCpuUsagePeak;
      _appMemoryUsagePeak = data.memoryInUseByApp > _appMemoryUsagePeak
          ? data.memoryInUseByApp
          : _appMemoryUsagePeak;
      setState(() => _data = data);
    } on PlatformException {
      throw PlatformException(
          code: 'Unknow-error', message: 'getResourceUsage');
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Plugin example app')),
          body: Center(
              child: _data != null
                  ? Table(
                      defaultColumnWidth: const FixedColumnWidth(120.0),
                      border: TableBorder.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2),
                      children: [
                          TableRow(children: [
                            Column(children: const [
                              Text('Resource', style: TextStyle(fontSize: 20.0))
                            ]),
                            Column(children: const [
                              Text('App', style: TextStyle(fontSize: 20.0))
                            ])
                          ]),
                          TableRow(children: [
                            Column(children: const [Text('RAM - Live')]),
                            Column(children: [
                              Text(formatBytes(
                                  _data!.memoryInUseByApp.toInt(), 2))
                            ])
                          ]),
                          TableRow(children: [
                            Column(children: const [Text('CPU - Live')]),
                            Column(children: [
                              Text('${_data?.cpuInUseByApp.floorToDouble()} %')
                            ])
                          ]),
                          TableRow(children: [
                            Column(children: const [Text('RAM - Peak')]),
                            Column(children: [
                              Text(formatBytes(_appMemoryUsagePeak.toInt(), 2))
                            ])
                          ]),
                          TableRow(children: [
                            Column(children: const [Text('CPU - Peak')]),
                            Column(children: [Text('$_appCpuUsagePeak')]),
                          ])
                        ])
                  : const CircularProgressIndicator()),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.memory), onPressed: _getResource)));
}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
}
