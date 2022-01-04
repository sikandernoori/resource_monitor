class Resource {
  // TODO(Sikander) Support overall system cpu/memory usage
  // late int cpuInUsebyOs;
  // late int memoryInUseByOs;
  // late int totalMemory;
  late double cpuInUseByApp;
  late double memoryInUseByApp;

  Resource.fromMap(Map map) {
    // TODO(Sikander) Support overall system cpu/memory usage
    // cpuInUsebyOs = map['cpuInUsebyOs'];
    // memoryInUseByOs = map['memoryInUseByOs'];
    // totalMemory = map['totalMemory'];
    cpuInUseByApp = map['cpuInUseByApp'];
    memoryInUseByApp = map['memoryInUseByApp'];
  }
}
