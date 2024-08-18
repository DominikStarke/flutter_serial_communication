import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'default.dart';

abstract class FlutterSerialCommunicationPlatformInterface extends PlatformInterface {
  /// Constructs a FlutterSerialCommunicationPlatform.
  FlutterSerialCommunicationPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static FlutterSerialCommunicationImplementation _instance =
      FlutterSerialCommunicationImplementation();

  static FlutterSerialCommunicationImplementation get instance => _instance;

  static set instance(FlutterSerialCommunicationImplementation instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
}
