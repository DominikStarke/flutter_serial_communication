import 'package:flutter/services.dart';
import 'package:flutter_serial_communication_platform_interface/default.dart';
import 'package:flutter_serial_communication_platform_interface/interface.dart';
import 'package:flutter_serial_communication_platform_interface/device.dart';

class FlutterSerialCommunication extends FlutterSerialCommunicationImplementation {
  @override
  Future<List<DeviceInfo>> getAvailableDevices() {
    return FlutterSerialCommunicationPlatformInterface.instance.getAvailableDevices();
  }

  @override
  Future<bool> connect(DeviceInfo deviceInfo, int baudRate) async {
    return FlutterSerialCommunicationPlatformInterface.instance
        .connect(deviceInfo, baudRate);
  }

  @override
  Future<void> disconnect() async {
    return FlutterSerialCommunicationPlatformInterface.instance.disconnect();
  }

  @override
  Future<bool> write(Uint8List data) async {
    final isSent =
        await FlutterSerialCommunicationPlatformInterface.instance.write(data);
    return isSent;
  }

  @override
  getSerialMessageListener() {
    return FlutterSerialCommunicationPlatformInterface.instance
        .getSerialMessageListener();
  }

  @override
  getDeviceConnectionListener() {
    return FlutterSerialCommunicationPlatformInterface.instance
        .getDeviceConnectionListener();
  }

  @override
  Future<void> setDTR(bool set) async {
    return FlutterSerialCommunicationPlatformInterface.instance.setDTR(set);
  }

  @override
  Future<void> setRTS(bool set) async {
    return FlutterSerialCommunicationPlatformInterface.instance.setRTS(set);
  }

  @override
  Future<void> setParameters(
      int baudRate, int dataBits, int stopBits, int parity) async {
    return FlutterSerialCommunicationPlatformInterface.instance
        .setParameters(baudRate, dataBits, stopBits, parity);
  }

  @override
  Future<void> purgeHwBuffers(
      bool purgeWriteBuffers, bool purgeReadBuffers) async {
    return FlutterSerialCommunicationPlatformInterface.instance
        .purgeHwBuffers(purgeWriteBuffers, purgeReadBuffers);
  }
}
