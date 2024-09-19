import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tocoron_app_flutter/app/lang/ui_texts.dart';
import 'package:tocoron_app_flutter/presentation/common_widgets/backgrounds/error_message_cubit.dart';
import 'package:tocoron_app_flutter/presentation/view/welcome_view.dart';

class TestConfiguration {
  final TargetPlatform platform;
  final List<Size> sizes;

  TestConfiguration({required this.platform, required this.sizes});
}

final testConfigurations = [
  TestConfiguration(
    platform: TargetPlatform.android,
    sizes: [
      const Size(340, 740),
      const Size(340, 740),
      const Size(360, 740),
      const Size(360, 780),
      const Size(1080, 1800),
      const Size(1080, 1920),
      const Size(1080, 2340),
      const Size(1284, 2778),
    ],
  ),
  TestConfiguration(
    platform: TargetPlatform.iOS,
    sizes: [
      const Size(320, 480),
      const Size(408, 886),
      const Size(428, 926),
      const Size(1284, 2778),
    ],
  ),
];

class TestWidgetBuilder {
  static Widget build({required Widget child, required Size size}) {
    return MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(size: size),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => UiTexts(const Locale('es')),
            ),
            BlocProvider<ErrorMessageCubit>(
              create: (context) => ErrorMessageCubit(),
            ),
          ],
          child: child,
        ),
      ),
    );
  }
}

void _runTestsForView(Widget view, List<Size> sizes, TargetPlatform platform) {
  group('View: $view', () {
    for (final size in sizes) {
      testWidgets("Basic Overflow: Size: (${size.width}, ${size.height})",
          (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        debugDefaultTargetPlatformOverride = platform;

        await tester.runAsync(() async {
          var testingView = TestWidgetBuilder.build(child: view, size: size);

          await tester.pumpWidget(
            TestWidgetBuilder.build(child: testingView, size: size),
          );

          expect(find.byWidget(testingView), findsOneWidget);
        });

        tester.view.resetPhysicalSize();
        debugDefaultTargetPlatformOverride = null;
        await tester.pumpAndSettle();
      });
    }
  });
}

void main() {
  final viewTest = [
    const WelcomeView(),
  ];

  setUp(() {});

  tearDown(() {});

  for (final config in testConfigurations) {
    group('Test platform: ${config.platform}', () {
      for (final view in viewTest) {
        _runTestsForView(view, config.sizes, config.platform);
      }
    });
  }
}
