import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/theme/ui_colors.dart';
import '../../../app/theme/ui_text_styles.dart';
import '../behaviors/ontap_wrapper.dart';
import 'error_message_cubit.dart';

class BaseBackground extends StatelessWidget {
  const BaseBackground({
    super.key,
    this.backgroundColor,
    this.backgroundImage = "",
    this.hasBackButton = false,
    this.hasFavoriteButton = false,
    this.hasAppBar = false,
    this.hasMenu = false,
    this.favoriteActions,
    required this.backActions,
    required this.content,
  });

  final Color? backgroundColor;
  final String backgroundImage;

  final bool hasBackButton;
  final bool hasFavoriteButton;
  final bool hasAppBar;
  final bool hasMenu;

  final Future<void> Function()? favoriteActions;
  final Future<void> Function() backActions;

  final Widget content;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double sideMargin = 32;
    Size touchingArea = Size(sideMargin + 40, 40);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, _) async {
        if (value) {
          return;
        }

        await backActions();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor ?? cBackground,
        body: Stack(
          children: [
            backgroundImage.isNotEmpty
                ? Image.asset(
                    backgroundImage,
                    width: screenSize.width,
                    fit: BoxFit.fitWidth,
                  )
                : const SizedBox.shrink(),
            SizedBox(
              width: screenSize.width,
              height: screenSize.height,
              child: content,
            ),
            hasBackButton
                ? OnTapWrapper(
                    widgetToWrap: Container(
                      width: touchingArea.width,
                      height: touchingArea.height,
                      padding: EdgeInsets.only(
                        left: sideMargin,
                      ),
                      alignment: Alignment.topLeft,
                      child: SvgPicture.asset(
                        "assets/images/arrow_back.svg",
                        fit: BoxFit.none,
                      ),
                    ),
                    actionsToDo: backActions,
                  )
                : const SizedBox.shrink(),
            BlocBuilder<ErrorMessageCubit, String>(
              builder: (context, message) {
                return message.isNotEmpty
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          margin: const EdgeInsets.only(bottom: 40),
                          decoration: BoxDecoration(
                            color: cBlackOpacity40,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            message,
                            style: styleRegular(14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
