import 'package:flutter/services.dart';
import 'package:flutter_serial_communication/models/device_info.dart';

import 'flutter_serial_communication_platform_interface.dart';

class FlutterSerialCommunication {
  Future<List<DeviceInfo>> getAvailableDevices() {
    return FlutterSerialCommunicationPlatform.instance.getAvailableDevices();
  }

  Future<bool> connect(DeviceInfo deviceInfo, int baudRate) async {
    return FlutterSerialCommunicationPlatform.instance
        .connect(deviceInfo, baudRate);
  }

  Future<void> disconnect() async {
    return FlutterSerialCommunicationPlatform.instance.disconnect();
  }

  Future<bool> write(Uint8List data) async {
    final isSent =
        await FlutterSerialCommunicationPlatform.instance.write(data);
    return isSent;
  }

  EventChannel getSerialMessageListener() {
    return FlutterSerialCommunicationPlatform.instance
        .getSerialMessageListener();
  }

  EventChannel getDeviceConnectionListener() {
    return FlutterSerialCommunicationPlatform.instance
        .getDeviceConnectionListener();
  }

  Future<void> setDTR(bool set) async {
    return FlutterSerialCommunicationPlatform.instance.setDTR(set);
  }

  Future<void> setRTS(bool set) async {
    return FlutterSerialCommunicationPlatform.instance.setRTS(set);
  }

  /// Set connection parameters and optional read buffer configuration
  /// 
  /// All parameters are optional. Read buffer parameters must be set before opening the port (before connect()) to take effect
  /// 
  /// Parameters:
  /// - [baudRate]: Baud rate for serial communication (optional)
  /// - [dataBits]: Number of data bits (optional)
  /// - [stopBits]: Number of stop bits (optional)
  /// - [parity]: Parity setting (optional)
  /// - [usbReadQueueCount]: Number of buffers in UsbSerialPort read queue (optional)
  /// - [usbReadQueueSize]: Size of each buffer in UsbSerialPort read queue (optional)
  /// - [usbIoManagerReadBufferSize]: Size of read buffer for SerialInputOutputManager (optional)
  /// - [usbIoManagerReadQueueCount]: Number of buffers in SerialInputOutputManager queue (optional)
  Future<void> setParameters({
      int? baudRate, 
      int? dataBits, 
      int? stopBits, 
      int? parity,
      int? usbReadQueueCount,
      int? usbReadQueueSize,
      int? usbIoManagerReadBufferSize,
      int? usbIoManagerReadQueueCount,
    }) async {
    return FlutterSerialCommunicationPlatform.instance
        .setParameters(
          baudRate: baudRate, 
          dataBits: dataBits, 
          stopBits: stopBits, 
          parity: parity,
          usbReadQueueCount: usbReadQueueCount,
          usbReadQueueSize: usbReadQueueSize,
          usbIoManagerReadBufferSize: usbIoManagerReadBufferSize,
          usbIoManagerReadQueueCount: usbIoManagerReadQueueCount,
        );
  }

  Future<void> purgeHwBuffers(
      bool purgeWriteBuffers, bool purgeReadBuffers) async {
    return FlutterSerialCommunicationPlatform.instance
        .purgeHwBuffers(purgeWriteBuffers, purgeReadBuffers);
  }
}
