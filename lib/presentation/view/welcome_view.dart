import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/lang/ui_texts.dart';
import '../../domain/use_cases/welcome_view_use_cases.dart';
import '../common_widgets/backgrounds/base_background.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  static const routeName = '/';

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  WelcomeViewUseCases welcomeViewUseCases = WelcomeViewUseCases();

  @override
  void initState() {
    super.initState();
    welcomeViewUseCases.initState(context)();
  }

  @override
  Widget build(BuildContext context) {
    UiTexts uiTexts = Provider.of<UiTexts>(context);
    Size screenSize = MediaQuery.of(context).size;

    return BaseBackground(
      backActions: welcomeViewUseCases.backActions(context),
      content: buildContent(
        screenSize,
        uiTexts,
      ),
    );
  }

  Widget buildContent(Size screenSize, UiTexts uiTexts) {
    return Container(
      margin: const EdgeInsets.only(top: 90, bottom: 51),
    );
  }
}
