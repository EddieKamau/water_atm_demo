import 'package:water_atm_demo/water_atm_demo.dart';

Future main() async {
  final app = Application<WaterAtmDemoChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 8888;

  await app.startOnCurrentIsolate();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
