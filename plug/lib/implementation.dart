import 'package:flutter/services.dart';
import 'package:flutter_serial_communication_platform_interface/interface.dart';
import 'package:flutter_serial_communication_platform_interface/device.dart';

class FlutterSerialCommunication {
  Future<List<DeviceInfo>> getAvailableDevices() {
    return FlutterSerialCommunicationPlatformInterface.instance.getAvailableDevices();
  }

  Future<bool> connect(DeviceInfo deviceInfo, int baudRate) async {
    return FlutterSerialCommunicationPlatformInterface.instance
        .connect(deviceInfo, baudRate);
  }

  Future<void> disconnect() async {
    return FlutterSerialCommunicationPlatformInterface.instance.disconnect();
  }

  Future<bool> write(Uint8List data) async {
    final isSent =
        await FlutterSerialCommunicationPlatformInterface.instance.write(data);
    return isSent;
  }

  EventChannel getSerialMessageListener() {
    return FlutterSerialCommunicationPlatformInterface.instance
        .getSerialMessageListener();
  }

  EventChannel getDeviceConnectionListener() {
    return FlutterSerialCommunicationPlatformInterface.instance
        .getDeviceConnectionListener();
  }

  Future<void> setDTR(bool set) async {
    return FlutterSerialCommunicationPlatformInterface.instance.setDTR(set);
  }

  Future<void> setRTS(bool set) async {
    return FlutterSerialCommunicationPlatformInterface.instance.setRTS(set);
  }

  Future<void> setParameters(
      int baudRate, int dataBits, int stopBits, int parity) async {
    return FlutterSerialCommunicationPlatformInterface.instance
        .setParameters(baudRate, dataBits, stopBits, parity);
  }

  Future<void> purgeHwBuffers(
      bool purgeWriteBuffers, bool purgeReadBuffers) async {
    return FlutterSerialCommunicationPlatformInterface.instance
        .purgeHwBuffers(purgeWriteBuffers, purgeReadBuffers);
  }
}
