import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:resource_monitor/resource_monitor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map? _data;

  @override
  void initState() {
    super.initState();
    _getResource();
  }

  Future<void> _getResource() async {
    Map data;
    try {
      data = await ResourceMonitor.getResourceUsage;
    } on PlatformException {
      throw PlatformException(
          code: 'Unknow-error', message: 'getResourceUsage');
    }
    if (!mounted) return;
    setState(() => _data = data);
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Plugin example app')),
          body: Center(child: Text('Resource usage: $_data\n')),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.memory), onPressed: _getResource)));
}
