
class UndoItem<T> {
  final Function(T) undoCallback;
  final Function(T) redoCallback;
  final T oldItem;
  final T newItem;

  UndoItem(this.oldItem,  this.newItem, this.undoCallback, this.redoCallback);

  void undo() {
    undoCallback.call(oldItem);
  }

  void redo() {
    redoCallback.call(newItem);
  }
}