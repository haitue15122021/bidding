import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' hide S;

import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import '../widget/common_widget.dart';

abstract class BaseScreen<T extends StatefulWidget> extends State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context) {}

  /// Get size screen
  Size get screenSize => MediaQuery.of(context).size;

  void showAlertDialog({
    String message = '',
    Function action,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 120,
                      color: appColorPrimary,
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.warning,
                          color: white,
                          size: 32,
                        ),
                        8.height,
                        Text(S.current.oops,
                            textAlign: TextAlign.center,
                            style: boldTextStyle(
                              color: white,
                              size: 18,
                            )),
                      ],
                    )
                  ],
                ),
                30.height,
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Text(
                    message,
                    style: secondaryTextStyle(),
                  ),
                ),
                16.height,
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (action != null) {
                      action.call();
                    }
                  },
                  child: Container(
                    decoration: boxDecoration(
                      bgColor: appColorPrimary,
                      radius: 10,
                    ),
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      8,
                      16,
                      8,
                    ),
                    child: Text(
                      S.current.tryAgain,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
                16.height,
              ],
            ),
          ),
          contentPadding: const EdgeInsets.all(
            0,
          ),
        );
      },
    );
  }
}
