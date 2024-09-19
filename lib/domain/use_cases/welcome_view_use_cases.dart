import 'package:flutter/material.dart';

import '../../app/theme/ui_colors.dart';
import '../../presentation/common_widgets/dialogs/log_out_dialog.dart';
import '../../presentation/view/welcome_view.dart';
import '../../utils/stamp.dart';

class WelcomeViewUseCases {
  final String _tag =
      WelcomeView.routeName.substring(1, WelcomeView.routeName.length);

  Future<void> Function() initState(BuildContext context) => () async {};

  Future<void> Function() backActions(BuildContext context) => () async {
        stamp(_tag, "Button Pressed: \"Back\"",
            decoratorChar: " * ", extraLine: true);

        showDialog(
          context: context,
          barrierColor: cBlackOpacity50,
          useSafeArea: false,
          builder: (BuildContext context) {
            return const LogOutDialog();
          },
        );
      };
}
