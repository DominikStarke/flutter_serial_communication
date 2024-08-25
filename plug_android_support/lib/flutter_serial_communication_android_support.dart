import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_serial_communication_platform_interface/default.dart';
import 'package:flutter_serial_communication_platform_interface/device.dart';
import 'package:flutter_serial_communication_platform_interface/interface.dart';

/// An implementation of [FlutterSerialCommunicationImplementation] that uses method channels.
class FlutterSerialCommunicationAndroidSupport extends FlutterSerialCommunicationImplementation {
  static void registerWith() {
    FlutterSerialCommunicationPlatformInterface.instance = FlutterSerialCommunicationAndroidSupport();
  }
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_serial_communication');

  /// Get list of available [DeviceInfo]
  @override
  Future<List<DeviceInfo>> getAvailableDevices() async {
    final availableDevices =
        await methodChannel.invokeMethod<String?>('getAvailableDevices');

    if (availableDevices == null || availableDevices == '[]') {
      return [];
    }

    final cleanedString = availableDevices.replaceAll('=', ':');
    final List<dynamic> rawDataList = jsonDecode(cleanedString);

    List<DeviceInfo> deviceInfos = [];
    deviceInfos = rawDataList.map((e) => DeviceInfo.fromMap(e)).toList();

    return deviceInfos;
  }

  /// Connect to device using [DeviceInfo]
  ///
  /// [DeviceInfo] got from returned array of [getAvailableDevices] also
  /// requires device's [baudRate] then
  /// returns [bool] to indicate whether the connection is success or not
  @override
  Future<bool> connect(DeviceInfo deviceInfo, int baudRate) async {
    final connectionData = <String, dynamic>{
      'name': deviceInfo.deviceName,
      'baudRate': baudRate,
    };

    final isConnected =
        await methodChannel.invokeMethod<bool>('connect', connectionData);
    return isConnected ?? false;
  }

  /// Disconnects from connected device
  @override
  Future<void> disconnect() async {
    await methodChannel.invokeMethod<bool>('disconnect');
  }

  /// Send data to serial port using [Uint8List]
  @override
  Future<bool> write(Uint8List data) async {
    final isSent = await methodChannel.invokeMethod<bool>('write', data);
    return isSent ?? false;
  }

  /// Listen to message received from serial port
  @override
  getSerialMessageListener() {
    const channel = EventChannel('$eventChannelID/serialStreamChannel');
    final stream = channel.receiveBroadcastStream().cast<List<int>>();
    return stream;
  }

  /// Listen to device connection status
  @override
  getDeviceConnectionListener() {
    const channel = EventChannel('$eventChannelID/deviceConnectionStreamChannel');
    final stream = channel.receiveBroadcastStream().cast<bool>();
    return stream;
  }

  /// Set usb DTR
  @override
  Future<bool> setDTR(bool set) async {
    final isSent = await methodChannel.invokeMethod<bool>('setDTR', set);
    return isSent ?? false;
  }

  /// Set usb RTS
  @override
  Future<bool> setRTS(bool set) async {
    final isSent = await methodChannel.invokeMethod<bool>('setRTS', set);
    return isSent ?? false;
  }

  /// Set connection parameters
  @override
  Future<bool> setParameters(
      int baudRate, int dataBits, int stopBits, int parity) async {
    final connectionParams = <String, dynamic>{
      'baudRate': baudRate,
      'dataBits': dataBits,
      'stopBits': stopBits,
      'parity': parity,
    };
    final isSent = await methodChannel.invokeMethod<bool>(
        'setParameters', connectionParams);
    return isSent ?? false;
  }

  @override
  Future<bool> purgeHwBuffers(
      bool purgeWriteBuffers, bool purgeReadBuffers) async {
    final commandParams = <String, dynamic>{
      'purgeWriteBuffers': purgeWriteBuffers,
      'purgeReadBuffers': purgeReadBuffers,
    };
    final isSent =
        await methodChannel.invokeMethod<bool>('purgeHwBuffers', commandParams);
    return isSent ?? false;
  }
}
