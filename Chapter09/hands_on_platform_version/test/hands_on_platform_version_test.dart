import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hands_on_platform_version/hands_on_platform_version.dart';

void main() {
  const MethodChannel channel = MethodChannel('hands_on_platform_version');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await HandsOnPlatformVersion.platformVersion, '42');
  });
}
