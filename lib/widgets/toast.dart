import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/services/navigation_service.dart';

import '../locator.dart';

enum ToastType { success, warning, error, info }

class TypeData {
  final Color color;
  final IconData icon;

  TypeData(this.color, this.icon);
}

enum ToastEvent { create, delete, modify }

String toastEventAsText(ToastEvent event) {
  switch (event) {
    case ToastEvent.create:
      return 'créé avec succès.';
    case ToastEvent.delete:
      return 'supprimé avec succès.';
    case ToastEvent.modify:
      return 'modifié avec succès.';
  }
}

/// Toast Length
/// Only for Android Platform
enum Toast {
  /// Show Short toast for 1 sec
  LENGTH_SHORT,

  /// Show Long toast for 5 sec
  LENGTH_LONG
}

/// ToastGravity
/// Used to define the position of the Toast on the screen
enum ToastGravity {
  TOP,
  BOTTOM,
  CENTER,
  TOP_LEFT,
  TOP_RIGHT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT,
  CENTER_LEFT,
  CENTER_RIGHT,
  SNACKBAR
}

/// Plugin to show a toast message on screen
/// Only for android, ios and Web platforms
class Fluttertoast {
  /// [MethodChannel] used to communicate with the platform side.
  static const MethodChannel _channel =
      const MethodChannel('PonnamKarthik/fluttertoast');

  /// Let say you have an active show
  /// Use this method to hide the toast immediately
  static Future<bool?> cancel() async {
    bool? res = await _channel.invokeMethod("cancel");
    return res;
  }

  /// Summons the platform's showToast which will display the message
  ///
  /// Wraps the platform's native Toast for android.
  /// Wraps the Plugin https://github.com/scalessec/Toast for iOS
  /// Wraps the https://github.com/apvarun/toastify-js for Web
  ///
  /// Parameter [msg] is required and remning all are options
  static Future<bool?> showToast({
    required String msg,
    Toast? toastLength,
    int timeInSecForIosWeb = 1,
    double? fontSize,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
    bool webShowClose = false,
    webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
    webPosition: "right",
  }) async {
    String toast = "short";
    if (toastLength == Toast.LENGTH_LONG) {
      toast = "long";
    }

    String gravityToast = "bottom";
    if (gravity == ToastGravity.TOP) {
      gravityToast = "top";
    } else if (gravity == ToastGravity.CENTER) {
      gravityToast = "center";
    } else {
      gravityToast = "bottom";
    }

    if (backgroundColor == null &&
        defaultTargetPlatform == TargetPlatform.iOS) {
      backgroundColor = Colors.black;
    }
    if (textColor == null && defaultTargetPlatform == TargetPlatform.iOS) {
      textColor = white;
    }
    final Map<String, dynamic> params = <String, dynamic>{
      'msg': msg,
      'length': toast,
      'time': timeInSecForIosWeb,
      'gravity': gravityToast,
      'bgcolor': backgroundColor != null ? backgroundColor.value : null,
      'textcolor': textColor != null ? textColor.value : null,
      'fontSize': fontSize,
      'webShowClose': webShowClose,
      'webBgColor': webBgColor,
      'webPosition': webPosition
    };

    bool? res = await _channel.invokeMethod('showToast', params);
    return res;
  }
}

/// Signature for a function to buildCustom Toast
typedef PositionedToastBuilder = Widget Function(
    BuildContext context, Widget child);

/// Runs on dart side this has no interaction with the Native Side
/// Works with all platforms just in two lines of code
/// final fToast = FToast().init(context)
/// fToast.showToast(child)
///
class FToast {
  BuildContext? context;

  static final FToast _instance = FToast._internal();

  /// Prmary Constructor for FToast
  factory FToast() {
    return _instance;
  }

  /// Take users Context and saves to avariable
  init(BuildContext context) {
    _instance.context = context;
  }

  FToast._internal();

  OverlayEntry? _entry;
  List<_ToastEntry> _overlayQueue = [];
  Timer? _timer;

  /// Internal function which handles the adding
  /// the overlay to the screen
  ///
  _showOverlay() {
    if (_overlayQueue.length == 0) {
      _entry = null;
      return;
    }
    _ToastEntry _toastEntry = _overlayQueue.removeAt(0);
    _entry = _toastEntry.entry;
    if (context == null)
      throw ("Error: Context is null, Please call init(context) before showing toast.");
    Overlay.of(context!)!.insert(_entry!);

    _timer = Timer(_toastEntry.duration!, () {
      Future.delayed(Duration(milliseconds: 360), () {
        removeCustomToast();
      });
    });
  }

  /// If any active toast present
  /// call removeCustomToast to hide the toast immediately
  removeCustomToast() {
    _timer?.cancel();
    _timer = null;
    if (_entry != null) _entry!.remove();
    _showOverlay();
  }

  /// FToast maintains a queue for every toast
  /// if we called showToast for 3 times we all to queue
  /// and show them one after another
  ///
  /// call removeCustomToast to hide the toast immediately
  removeQueuedCustomToasts() {
    _timer?.cancel();
    _timer = null;
    _overlayQueue.clear();
    if (_entry != null) _entry!.remove();
    _entry = null;
  }

  /// showToast accepts all the required paramenters and prepares the child
  /// calls _showOverlay to display toast
  ///
  /// Paramenter [child] is requried
  /// fadeDuration default is 350 milliseconds
  void showToast({
    required Widget child,
    PositionedToastBuilder? positionedToastBuilder,
    Duration? toastDuration,
    ToastGravity? gravity,
    int fadeDuration = 250,
  }) {
    Widget newChild = _ToastStateFul(
        child, toastDuration ?? Duration(seconds: 2),
        fadeDuration: fadeDuration);

    /// Check for keyboard open
    /// If open will ignore the gravity bottom and change it to center
    if (gravity == ToastGravity.BOTTOM) {
      if (MediaQuery.of(context!).viewInsets.bottom != 0) {
        gravity = ToastGravity.CENTER;
      }
    }

    OverlayEntry newEntry = OverlayEntry(builder: (context) {
      if (positionedToastBuilder != null)
        return positionedToastBuilder(context, newChild);
      return _getPostionWidgetBasedOnGravity(newChild, gravity);
    });

    _overlayQueue.add(_ToastEntry(
        entry: newEntry, duration: toastDuration ?? Duration(seconds: 2)));
    if (_timer == null) _showOverlay();
  }

  /// _getPostionWidgetBasedOnGravity generates [Positioned] [Widget]
  /// based on the gravity  [ToastGravity] provided by the user in
  /// [showToast]
  _getPostionWidgetBasedOnGravity(Widget child, ToastGravity? gravity) {
    switch (gravity) {
      case ToastGravity.TOP:
        return Positioned(top: 100.0, left: 24.0, right: 24.0, child: child);
      case ToastGravity.TOP_LEFT:
        return Positioned(top: 100.0, left: 24.0, child: child);
      case ToastGravity.TOP_RIGHT:
        return Positioned(top: 100.0, right: 24.0, child: child);
      case ToastGravity.CENTER:
        return Positioned(
            top: 50.0, bottom: 50.0, left: 24.0, right: 24.0, child: child);
      case ToastGravity.CENTER_LEFT:
        return Positioned(top: 50.0, bottom: 50.0, left: 24.0, child: child);
      case ToastGravity.CENTER_RIGHT:
        return Positioned(top: 50.0, bottom: 50.0, right: 24.0, child: child);
      case ToastGravity.BOTTOM_LEFT:
        return Positioned(bottom: 24.0, left: 24.0, child: child);
      case ToastGravity.BOTTOM_RIGHT:
        return Positioned(bottom: 50.0, right: 24.0, child: child);
      case ToastGravity.SNACKBAR:
        return Positioned(
            bottom: MediaQuery.of(context!).viewInsets.bottom,
            left: 0,
            right: 0,
            child: child);
      case ToastGravity.BOTTOM:
      default:
        return Positioned(bottom: 50.0, left: 24.0, right: 24.0, child: child);
    }
  }
}

/// internal class [_ToastEntry] which maintains
/// each [OverlayEntry] and [Duration] for every toast user
/// triggered
class _ToastEntry {
  final OverlayEntry? entry;
  final Duration? duration;

  _ToastEntry({this.entry, this.duration});
}

/// internal [StatefulWidget] which handles the show and hide
/// animations for [FToast]
class _ToastStateFul extends StatefulWidget {
  _ToastStateFul(this.child, this.duration, {Key? key, this.fadeDuration = 350})
      : super(key: key);

  final Widget child;
  final Duration duration;
  final int fadeDuration;

  @override
  ToastStateFulState createState() => ToastStateFulState();
}

/// State for [_ToastStateFul]
class ToastStateFulState extends State<_ToastStateFul>
    with SingleTickerProviderStateMixin {
  /// Start the showing animations for the toast
  showIt() {
    _animationController!.forward();
  }

  /// Start the hidding animations for the toast
  hideIt() {
    _animationController!.reverse();
    _timer?.cancel();
  }

  /// Controller to start and hide the animation
  AnimationController? _animationController;
  late Animation _fadeAnimation;
  late Animation _offsetAnimation;
  Timer? _timer;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.fadeDuration),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeIn);
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.2, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeOut,
    ));
    super.initState();

    showIt();
    _timer = Timer(widget.duration, () {
      hideIt();
    });
  }

  @override
  void deactivate() {
    _timer?.cancel();
    _animationController!.stop();
    super.deactivate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: _offsetAnimation as Animation<Offset>,
        child: FadeTransition(
          opacity: _fadeAnimation as Animation<double>,
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: widget.child,
            ),
          ),
        ));
  }
}

TypeData toastIconColor(ToastType type) {
  switch (type) {
    case ToastType.success:
      return TypeData(lightBlue, Icons.check_circle);
    case ToastType.warning:
      return TypeData(lightOrange, Icons.warning_rounded);
    case ToastType.error:
      return TypeData(lightRed, Icons.error_rounded);
    case ToastType.info:
      return TypeData(lightPurple, Icons.info_rounded);
  }
}

showToast(ToastType type, String name, {String? toastText, ToastEvent? event}) {
  FToast fToast = FToast();
  fToast.init(locator<NavigationService>().navigatorKey.currentContext!);
  fToast.removeCustomToast();
  Widget toast = Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1.5,
          blurRadius: 1.5,
        ),
      ],
      borderRadius: BorderRadius.circular(2),
      color: white,
    ),
    child: IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    bottomLeft: Radius.circular(2)),
                color: toastIconColor(type).color,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Icon(
                    toastIconColor(type).icon,
                    color: toastIconColor(type).color,
                    size: 22,
                  ),
                )
              ]),
          Container(
              constraints: BoxConstraints(maxWidth: 300),
              padding: EdgeInsets.all(20),
              child: Text.rich(TextSpan(
                children: [
                  TextSpan(text: "« $name »", style: textStyle_Text_12_600),
                  TextSpan(
                    text: (event == null)
                        ? " " + toastText!
                        : " " + toastEventAsText(event),
                    style: TextStyle(
                        color: text,
                        fontSize: 12,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ))),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: CustomIconButton(
                      icon: Icons.close_rounded,
                      color: lightRed,
                      size: 15,
                      enableToolTip: false,
                      message: '',
                      onTap: () {
                        fToast.removeCustomToast();
                      },
                    ),
                  ),
                )
              ]),
        ],
      ),
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM_LEFT,
    toastDuration: Duration(seconds: 3),
  );
}
