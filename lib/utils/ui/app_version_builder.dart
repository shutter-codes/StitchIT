import 'package:flutter/material.dart';
import 'package:get_version/get_version.dart';

class AppVersion {
  static Future<String> retrieve(bool shouldMockValue, {String mockValue = "1.0"}) =>
      shouldMockValue == true ? Future.value(mockValue) : GetVersion.projectVersion;
}

class AppVersionBuilder extends StatefulWidget {
  const AppVersionBuilder({Key key, @required this.valueBuilder, @required this.builder, this.child})
      : assert(valueBuilder != null),
        assert(builder != null),
        super(key: key);

  final Future<String> Function() valueBuilder;
  final ValueWidgetBuilder<String> builder;
  final Widget child;

  @override
  _AppVersionBuilderState createState() => _AppVersionBuilderState();
}

class _AppVersionBuilderState extends State<AppVersionBuilder> {
  Future<String> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.valueBuilder();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData && snapshot.data != null && snapshot.data.isNotEmpty) {
          return widget.builder(context, snapshot.data, widget.child);
        }
        return const SizedBox();
      },
    );
  }
}
