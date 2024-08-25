import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:flutter_serial_communication_platform_interface/default.dart';
import 'package:flutter_serial_communication_platform_interface/device.dart';
import 'package:flutter_serial_communication_platform_interface/interface.dart';

typedef SerialPortDesktop = DeviceInfo<SerialPort>;

/// An implementation of [FlutterSerialCommunicationImplementation] that uses ffi bindings
/// based on https://github.com/jpnurmi/libserialport.dart
class FlutterSerialCommunicationDesktopSupport extends FlutterSerialCommunicationImplementation {
  static void registerWith() {
    FlutterSerialCommunicationPlatformInterface.instance = FlutterSerialCommunicationDesktopSupport();
  }

  final _serialMessageListener = StreamController<Uint8List>.broadcast();
  final _deviceConnectionListener = StreamController<bool>.broadcast();
  StreamSubscription<Uint8List>? _serialPortSubscription;
  SerialPortDesktop? _deviceInfo;
  bool _connected = false;

  @override
  Future<List<DeviceInfo>> getAvailableDevices() async {
    final availablePorts = SerialPort.availablePorts;
    final devices = <DeviceInfo>[];
    for (String p in availablePorts) {
      final port = SerialPort(p);
      devices.add(SerialPortDesktop(
        productName: port.productName ?? "",
        deviceName: port.name ?? "",
        vendorId: port.vendorId,
        productId: port.productId,
        deviceId: port.productId,
        manufacturerName: port.manufacturer ?? "",
        serialNumber: port.serialNumber ?? "",
        version: "Unsupported",
        port: port,
      ));
    }
    return devices;
  }

  @override
  Future<bool> connect(DeviceInfo deviceInfo, int baudRate) async {
    await disconnect();
    
    if(deviceInfo is SerialPortDesktop) {
      _deviceInfo = deviceInfo;
      final port = deviceInfo.port;

      if (port == null) {
        await disconnect();
        throw SerialPort.lastError ?? const SerialPortError("An Unknown Error Occurred");
      }

      if(Platform.isMacOS || Platform.isLinux) {
        port..open(mode: SerialPortMode.read)
            ..close();
      }

      if (port.openReadWrite() != true) {
        await disconnect();
        throw SerialPort.lastError ?? const SerialPortError("An Unknown Error Occurred");
      }

      port.config = SerialPortConfig()
        ..baudRate = baudRate;

      _connected = true;
      
      await setReader();
      _broadcastDeviceConnectionStatusChange(_connected);
      
      return true;
    } else {
      throw ArgumentError("deviceInfo must be of type DesktopPortInfo");
    }
  }

  @override
  Future<void> disconnect() async {
    if(!_connected) return;
    _deviceInfo?.port?.close();
    _connected = false;
    // _deviceInfo?.port?.dispose(); // ???
    _broadcastDeviceConnectionStatusChange(_connected);
  }

  @override
  Future<bool> write(Uint8List data, [int timeout = -1]) async {
    _deviceInfo?.port?.write(data, timeout: timeout);
    return true;
  }

  @override
  getSerialMessageListener() {
    return _serialMessageListener.stream.map((data) => List<int>.from(data));
  }

  @override
  getDeviceConnectionListener() {
    return _deviceConnectionListener.stream;
  }

  // Function to broadcast a message received from the SerialPort
  void _broadcastSerialMessage(Uint8List data) {
    _serialMessageListener.add(data);
  }

  // Function to broadcast the device connection status change
  void _broadcastDeviceConnectionStatusChange(bool isConnected) {
    _deviceConnectionListener.add(isConnected);
  }

  Future<void> setReader () async {
    if(_deviceInfo?.port == null) return;

    _serialPortSubscription?.cancel();
    _serialPortSubscription = SerialPortReader(_deviceInfo!.port!)
      .stream.listen(_broadcastSerialMessage)
        ..onError((err) async {
          await disconnect();
        });
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
  Future<void> setParameters(int baudRate, int dataBits, int stopBits, int parity) {
    throw UnimplementedError('setParameters() has not been implemented.');
  }

  @override
  Future<void> purgeHwBuffers(bool purgeWriteBuffers, bool purgeReadBuffers) {
    throw UnimplementedError('purgeHwBuffers() has not been implemented.');
  }
}
