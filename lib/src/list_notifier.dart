import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:supa_manager/supa_manager.dart';

class ListNotifier<T extends HasId> extends StateNotifier<List<T>> {
  final SupaDatabaseManager databaseRepository;
  final TableData<T> tableData;
  final TableEntryCreator<T> tableEntryCreator;

  ListNotifier(this.databaseRepository, this.tableData, this.tableEntryCreator)
      : super(<T>[]);

  Future initializeAll() async {
    final result = await databaseRepository.readEntries(tableData);
    setStateFromResult(result);
  }

  Future initializeValue(String columnName, int value) async {
    final result = await databaseRepository.readEntriesWhere(tableData, columnName, value);
    setStateFromResult(result);
  }

  Future initializeValues(List<SelectEntry> selections) async {
    final result = await databaseRepository.selectEntriesWhere(tableData, selections);
    setStateFromResult(result);
  }

  void setStateFromResult(Result<List<T>>  result) {
    result.when(success: (data) {
      state = data;
    }, failure: (Exception error) {
      log('Problems getting results', error: error);
    }, errorMessage: (int code, String? message) {
      log('Problems getting results: $message');
    });
  }

  Future<Result<T?>> addEntry(T entry) async {
    final result = await databaseRepository.addEntry(tableData, tableEntryCreator.call(entry));
    result.when(success: (data) {
      state = [...state, data];
    }, failure: (error) {
      logError(error.toString());
    }, errorMessage: (int code, String? message) {
      logError(message);
    });
    return result;
  }

  T? getEntry(int id) {
    return state.firstWhere((element) => element.tableId == id);
  }

  Future<Result<T?>> removeEntry(T entryToRemove) async {
    state = [
      for (final entry in state)
        if (entry.tableId != entryToRemove.tableId) entry,
    ];
    return databaseRepository.deleteTableEntry(
        tableData, tableEntryCreator.call(entryToRemove));
  }

  Future<Result<T?>> updateEntry(T entryToReplace) async {
    final index =
        state.indexWhere((element) => element.tableId == entryToReplace.tableId);
    if (index == -1) {
      log('Task not found: $entryToReplace');
      return Result.errorMessage(1, 'Task not found: $entryToReplace');
    }
    final result = await databaseRepository.updateTableEntry(
        tableData, tableEntryCreator.call(entryToReplace));
    result.when(success: (data) {
      final copyOfState = [...state];
      copyOfState[index] = data;
      state = copyOfState;
    }, failure: (error) {
      logError(error.toString());
    }, errorMessage: (int code, String? message) {
      logError(message);
    });
    return result;
  }
}
