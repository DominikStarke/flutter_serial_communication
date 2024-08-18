import 'package:flutter/services.dart';
import 'device.dart';
import 'interface.dart';

class FlutterSerialCommunicationImplementation extends FlutterSerialCommunicationPlatformInterface{
  Future<List<DeviceInfo>> getAvailableDevices() {
    throw UnimplementedError('getAvailableDevices() has not been implemented.');
  }

  Future<bool> connect(DeviceInfo deviceInfo, int baudRate) {
    throw UnimplementedError('connect() has not been implemented.');
  }

  Future<void> disconnect() {
    throw UnimplementedError('disconnect() has not been implemented.');
  }

  Future<bool> write(Uint8List data) {
    throw UnimplementedError('write() has not been implemented.');
  }

  EventChannel getSerialMessageListener() {
    throw UnimplementedError(
        'getSerialMessageListener() has not been implemented.');
  }

  EventChannel getDeviceConnectionListener() {
    throw UnimplementedError(
        'getDeviceConnectionListener() has not been implemented.');
  }

  Future<void> setDTR(bool set) {
    throw UnimplementedError('setDTR() has not been implemented.');
  }

  Future<void> setRTS(bool set) {
    throw UnimplementedError('setRTS() has not been implemented.');
  }

  Future<void> setParameters(
      int baudRate, int dataBits, int stopBits, int parity) {
    throw UnimplementedError('setParameters() has not been implemented.');
  }

  Future<void> purgeHwBuffers(bool purgeWriteBuffers, bool purgeReadBuffers) {
    throw UnimplementedError('purgeHwBuffers() has not been implemented.');
  }
}
