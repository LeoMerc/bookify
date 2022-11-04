import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ButtonOptions {
  ButtonOptions({
    this.textStyle,
    this.elevation,
    this.height = 0,
    this.width = 0,
    this.padding,
    required this.color,
    this.disabledColor = const Color(0xFF57636C),
    this.disabledTextColor = const Color(0xFFc1c7cc),
    this.splashColor,
    this.iconSize,
    this.iconColor,
    this.iconPadding,
    this.borderRadius,
    this.borderSide,
  });

  final TextStyle? textStyle;
  final double? elevation;
  final double height;
  final double width;
  final EdgeInsetsGeometry? padding;
  final Color color;
  final Color disabledColor;
  final Color disabledTextColor;
  final Color? splashColor;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final double? borderRadius;
  final BorderSide? borderSide;
}

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconData,
    required this.options,
    this.showLoadingIndicator = true,
    this.cerrar = false,
  }) : super(key: key);

  final String text;
  final Widget? icon;
  final IconData? iconData;
  final Function() onPressed;
  final ButtonOptions options;
  final bool showLoadingIndicator;
  final bool cerrar;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Widget textWidget = loading
        ? Center(
            child: SizedBox(
              width: 23,
              height: 23,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.options.textStyle?.color ?? Colors.white,
                ),
              ),
            ),
          )
        : AutoSizeText(
            widget.text,
            style: TextStyle(
                color: widget.cerrar
                    ? Colors.purple
                    : Colors.grey,
                fontWeight: FontWeight.w400),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );

    final onPressed = widget.showLoadingIndicator
        ? () async {
            if (loading) {
              return;
            }
            setState(() => loading = true);
            try {
              await widget.onPressed();
            } finally {
              if (mounted) {
                setState(() => loading = false);
              }
            }
          }
        : () => widget.onPressed();

    ButtonStyle style = ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(widget.options.borderRadius ?? 8.0),
          side: widget.options.borderSide ?? BorderSide.none,
        ),
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return widget.options.disabledTextColor;
          }
          return widget.options.textStyle?.color;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return widget.options.disabledColor;
          }
          return widget.options.color;
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.pressed)) {
          return widget.options.splashColor;
        }
        return null;
      }),
      padding: MaterialStateProperty.all(widget.options.padding ??
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)),
      elevation:
          MaterialStateProperty.all<double>(widget.options.elevation ?? 2.0),
    );

    if (widget.icon != null || widget.iconData != null) {
      return SizedBox(
        height: widget.options.height,
        width: widget.options.width * .85,
        child: ElevatedButton(
          child: Text(
            '',
            style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
          ),
          // icon: Padding(
          //   padding: widget.options.iconPadding ?? EdgeInsets.zero,
          //   child: widget.icon ??
          //       FaIcon(
          //         widget.iconData,
          //         size: widget.options.iconSize,
          //         color: widget.options.iconColor ??
          //             widget.options.textStyle?.color,
          //       ),
          // ),
          // label: textWidget,
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
        ),
      );
    }

    return SizedBox(
      height: widget.options.height * .80,
      width: widget.options.width * .46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(widget.options.color),
        ),
        child: textWidget,
      ),
    );
  }
}

class CustomButtonCambioContra extends StatefulWidget {
  const CustomButtonCambioContra({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconData,
    required this.options,
    this.showLoadingIndicator = true,
    this.cerrar = false,
  }) : super(key: key);

  final String text;
  final Widget? icon;
  final IconData? iconData;
  final Function() onPressed;
  final ButtonOptions options;
  final bool showLoadingIndicator;
  final bool cerrar;

  @override
  State<CustomButton> createState() => _CustomButtonStateCambioContra();
}

class _CustomButtonStateCambioContra extends State<CustomButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Widget textWidget = loading
        ? Center(
            child: SizedBox(
              width: 23,
              height: 23,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.options.textStyle?.color ?? Colors.white,
                ),
              ),
            ),
          )
        : AutoSizeText(
            widget.text,
            style: TextStyle(
                color: widget.cerrar
                    ? Colors.purple
                    : Colors.grey,
                fontWeight: FontWeight.w400),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );

    final onPressed = widget.showLoadingIndicator
        ? () async {
            if (loading) {
              return;
            }
            setState(() => loading = true);
            try {
              await widget.onPressed();
            } finally {
              if (mounted) {
                setState(() => loading = false);
              }
            }
          }
        : () => widget.onPressed();

    ButtonStyle style = ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(widget.options.borderRadius ?? 8.0),
          side: widget.options.borderSide ?? BorderSide.none,
        ),
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return widget.options.disabledTextColor;
          }
          return widget.options.textStyle?.color;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return widget.options.disabledColor;
          }
          return widget.options.color;
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.pressed)) {
          return widget.options.splashColor;
        }
        return null;
      }),
      padding: MaterialStateProperty.all(widget.options.padding ??
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)),
      elevation:
          MaterialStateProperty.all<double>(widget.options.elevation ?? 2.0),
    );

    if (widget.icon != null || widget.iconData != null) {
      return SizedBox(
        height: widget.options.height,
        width: widget.options.width * .85,
        child: ElevatedButton(
          child: Text(
            '',
            style:TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
          ),
          // icon: Padding(
          //   padding: widget.options.iconPadding ?? EdgeInsets.zero,
          //   child: widget.icon ??
          //       FaIcon(
          //         widget.iconData,
          //         size: widget.options.iconSize,
          //         color: widget.options.iconColor ??
          //             widget.options.textStyle?.color,
          //       ),
          // ),
          // label: textWidget,
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
        ),
      );
    }

    return SizedBox(
      height: widget.options.height * .80,
      width: widget.options.width * .86,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(widget.options.color),
        ),
        child: textWidget,
      ),
    );
  }
}
