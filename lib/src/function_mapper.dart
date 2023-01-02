

import 'package:collection/collection.dart';

class FuncData {
  final String name;
  final Function function;

  FuncData(this.name, this.function);
}

Function? findFunction(List<FuncData> data, String name) {
  return data.firstWhereOrNull((funcData) => funcData.name == name)?.function;
}