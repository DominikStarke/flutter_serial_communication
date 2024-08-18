import 'package:flutter/services.dart';
import 'package:flutter_serial_communication_desktop_support/port.dart';
import 'package:flutter_serial_communication_platform_interface/default.dart';
import 'package:flutter_serial_communication_platform_interface/device.dart';
import 'package:flutter_serial_communication_platform_interface/interface.dart';

/// An implementation of [FlutterSerialCommunicationImplementation] that uses ffi bindings
/// based on https://github.com/jpnurmi/libserialport.dart
class FlutterSerialCommunicationDesktopSupport extends FlutterSerialCommunicationImplementation {
  static void registerWith() {
    FlutterSerialCommunicationPlatformInterface.instance = FlutterSerialCommunicationDesktopSupport();
  }

  @override
  Future<List<DeviceInfo>> getAvailableDevices() {
    final name = SerialPort.availablePorts;
    throw UnimplementedError('getAvailableDevices() has not been implemented.');
  }

  @override
  Future<bool> connect(DeviceInfo deviceInfo, int baudRate) {
    throw UnimplementedError('connect() has not been implemented.');
  }

  @override
  Future<void> disconnect() {
    throw UnimplementedError('disconnect() has not been implemented.');
  }

  @override
  Future<bool> write(Uint8List data) {
    throw UnimplementedError('write() has not been implemented.');
  }

  @override
  EventChannel getSerialMessageListener() {
    return const EventChannel("");
  }

  @override
  EventChannel getDeviceConnectionListener() {
    return const EventChannel("");
  }

  @override
  Future<void> setDTR(bool set) {
    throw UnimplementedError('setDTR() has not been implemented.');
  }

  @override
  Future<void> setRTS(bool set) {
    throw UnimplementedError('setRTS() has not been implemented.');
  }

  @override
  Future<void> setParameters(
      int baudRate, int dataBits, int stopBits, int parity) {
    throw UnimplementedError('setParameters() has not been implemented.');
  }

  @override
  Future<void> purgeHwBuffers(bool purgeWriteBuffers, bool purgeReadBuffers) {
    throw UnimplementedError('purgeHwBuffers() has not been implemented.');
  }

}
