import 'dart:collection';

import 'undo_item.dart';

class UndoManager {
  final Queue<UndoItem> _history = ListQueue();
  final Queue<UndoItem> _redos = ListQueue();

  void clear() {
    _history.clear();
  }

  void addUndo(UndoItem item) {
    _history.addLast(item);
    _redos.clear();
  }

  void undo() {
    if (_history.isNotEmpty) {
      final undo = _history.removeLast();
      _redos.addFirst(undo);
      undo.undo();
    }
  }

  void redo() {
    if (_redos.isNotEmpty) {
      final undo = _redos.removeFirst();
      _history.addLast(undo);
      undo.redo();
    }
  }
}
