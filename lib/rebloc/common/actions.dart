import 'package:rebloc/rebloc.dart';

class OnInitAction extends Action {
  const OnInitAction();
}

class OnDisposeAction extends Action {
  const OnDisposeAction();
}

class VoidAction extends Action {
  const VoidAction();
}

class OnDataAction<T> extends Action {
  const OnDataAction(this.payload) : assert(payload != null);

  final T payload;
}
