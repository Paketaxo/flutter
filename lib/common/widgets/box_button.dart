import 'package:base/common/theme/colors.dart';
import 'package:base/common/theme/styles.dart';
import 'package:flutter/material.dart';

class BoxButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final bool busy;
  final void Function()? onTap;
  final bool outline;
  final MainAxisSize? mainAxisSize;
  final Widget? leading;
  final Color? backgrounColor;
  final double? width;

  const BoxButton({
    Key? key,
    required this.title,
    this.disabled = false,
    this.busy = false,
    this.onTap,
    this.leading,
    this.backgrounColor = kcPrimaryColor,
    this.mainAxisSize,
    this.width,
  })  : outline = false,
        super(key: key);

   const BoxButton.outline({Key? key, 
    required this.title,
    this.onTap,
    this.leading,
    this.backgrounColor,
    this.mainAxisSize,
    this.width,
  })  : disabled = false,
        busy = false,
        outline = true, super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        height: 48,
        width: (width == null) ? title.length * 12.0 : width,
        alignment: Alignment.center,
        decoration: !outline
            ? BoxDecoration(
                color: !disabled ? backgrounColor : kcMediumGreyColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 2.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              )
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: kcPrimaryColor,
                  width: 1,
                )),
        child: !busy
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) leading!,
                  if (leading != null) const SizedBox(width: 8),
                  Text(
                    title,
                    style: buttonTextStyle.copyWith(
                      fontWeight: !outline ? FontWeight.bold : FontWeight.w400,
                      fontSize: 14,
                      color: !outline ? Colors.white : backgrounColor,
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
      ),
    );
  }
}
