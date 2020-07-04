
import 'package:flutter/material.dart';
class DialogEdit extends StatefulWidget {

  const DialogEdit({
    Key key,
    this.title,
    this.titlePadding = const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    this.children,
    this.contentPadding = const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.shape,
  }) : assert(titlePadding != null),
       assert(contentPadding != null),
       super(key: key);

 
  final Widget title;

 
  final EdgeInsetsGeometry titlePadding;


  final List<Widget> children;

 
  final EdgeInsetsGeometry contentPadding;

  /// {@macro flutter.material.dialog.backgroundColor}
  final Color backgroundColor;

  /// {@macro flutter.material.dialog.elevation}
  /// {@macro flutter.material.material.elevation}
  final double elevation;

  
  final String semanticLabel;

  /// {@macro flutter.material.dialog.shape}
  final ShapeBorder shape;

  @override
  _DialogEditState createState() => _DialogEditState();
}

class _DialogEditState extends State<DialogEdit> {
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);

    String label = widget.semanticLabel;
    if (widget.title == null) {
      switch (theme.platform) {
        case TargetPlatform.macOS:
        case TargetPlatform.iOS:
          label = widget.semanticLabel;
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          label = widget.semanticLabel ?? MaterialLocalizations.of(context)?.dialogLabel;
      }
    }

    Widget dialogChild = IntrinsicWidth(
      stepWidth: 56.0,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (widget.title != null)
              Padding(
                padding: widget.titlePadding,
                child: DefaultTextStyle(
                  style: theme.textTheme.headline6,
                  child: Semantics(namesRoute: true, child: widget.title),
                ),
              ),
            if (widget.children != null)
              Flexible(
                child: SingleChildScrollView(
                  padding: widget.contentPadding,
                  child: ListBody(children: widget.children),
                ),
              ),
          ],
        ),
      ),
    );

    if (label != null)
      dialogChild = Semantics(
        namesRoute: true,
        label: label,
        child: dialogChild,
      );
    return Dialog(
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      shape: widget.shape,
      child: dialogChild,
    );
  }
}



