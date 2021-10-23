import 'package:aquedart_test/aquedart_test.dart';
import 'package:water_atm_demo/water_atm_demo.dart';

export 'package:aquedart/aquedart.dart';
export 'package:aquedart_test/aquedart_test.dart';
export 'package:test/test.dart';
export 'package:water_atm_demo/water_atm_demo.dart';

/// A testing harness for water_atm_demo.
///
/// A harness for testing an aquedart application. Example test file:
///
///         void main() {
///           Harness harness = Harness()..install();
///
///           test("GET /path returns 200", () async {
///             final response = await harness.agent.get("/path");
///             expectResponse(response, 200);
///           });
///         }
///
class Harness extends TestHarness<WaterAtmDemoChannel> {
  @override
  Future onSetUp() async {}

  @override
  Future onTearDown() async {}
}
