import 'package:auto_size_text/auto_size_text.dart';
import 'package:base/common/theme/styles.dart';
import 'package:flutter/material.dart';
// import 'package:auto_size_text/auto_size_text.dart';

// import '../../../constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  TextStyle style;

  bool multiline = true;
  int maxLines = 2;
  Color? color;
  // AutoSizeGroup? group;
  double? maxFontSizeFactor;
  TextAlign? align;

  CustomText.headline1(
    this.text, {Key? key, 
    this.maxLines = 1,
    this.multiline = false,
    this.align,
  }) : style = headline1, super(key: key);
  CustomText.headline2(this.text, {Key? key}) : style = headline2, super(key: key);
  CustomText.appBar(this.text, {Key? key})
      : style = headline5.copyWith(color: Colors.white), super(key: key);
  CustomText.headline3(this.text, {Key? key}) : style = headline3, super(key: key);
  CustomText.headline4(this.text, {Key? key, this.maxLines = 3}) : style = headline4, super(key: key);
  CustomText.headline5(
    this.text, {Key? key, 
    this.maxLines = 3,
  })  : style = headline5,
        multiline = true, super(key: key);
  CustomText.caption(
    this.text, {Key? key, 
    this.maxLines = 3,
  })  : style = caption,
        multiline = true, super(key: key);
  CustomText.errorCaption(
    this.text, {Key? key, 
    this.maxLines = 3,
  })  : style = caption.copyWith(color: Colors.red),
        multiline = true, super(key: key);
  CustomText.boldCaption(
    this.text, {Key? key, 
    this.maxLines = 3,
  })  : style = caption.copyWith(fontWeight: FontWeight.bold),
        multiline = true, super(key: key);
  CustomText.forDropdown(this.text, {Key? key})
      : style = caption,
        multiline = false, super(key: key);
  CustomText.overline(this.text, {Key? key}) : style = overline, super(key: key);
  CustomText.subtitle1(this.text, {Key? key}) : style = subtitle1, super(key: key);
  CustomText.subtitle2(this.text, {Key? key})
      : style = subtitle2,
        multiline = true,
        maxLines = 3,
        align = TextAlign.left, super(key: key);
  CustomText.errorSubtitle2(this.text, {Key? key})
      : style = subtitle2.copyWith(color: Colors.red),
        maxLines = 2,
        multiline = true, super(key: key);
  CustomText.bodyText1(
    this.text, {Key? key, 
    this.maxLines = 2,
  }) : style = bodyText1, super(key: key);
  CustomText.bodyText2(this.text, {Key? key}) : style = bodyText2, super(key: key);
  CustomText.button(this.text, {Key? key}) : style = buttonTextStyle, super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    if (multiline) {
      AutoSizeText(
        text,
        style: color != null ? style : style.copyWith(color: color),
        maxLines: maxLines,
        textAlign: align,
        overflow: TextOverflow.ellipsis,
        textScaleFactor: query.textScaleFactor.clamp(0.8, 1.35),
      );
    }
    return AutoSizeText(
      text,
      style: color != null ? style : style.copyWith(color: color),
      wrapWords: false,
      textAlign: align,
      overflow: TextOverflow.visible,
      textScaleFactor: query.textScaleFactor.clamp(0.8, 1.35),
    );
  }
}
