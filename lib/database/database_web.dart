import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/services.dart';
import 'package:sqlite3/wasm.dart';

QueryExecutor openConnection() {
  return DatabaseConnection.delayed(
    Future(() async {
      final sqlite = await WasmSqlite3.loadFromUrl(Uri.parse('sqlite3.wasm'));
      final fileSystem = await IndexedDbFileSystem.open(
        dbName: 'cuentas_claras',
      );
      sqlite.registerVirtualFileSystem(fileSystem, makeDefault: true);
      await rootBundle.load('web/sqlite3.wasm');
      return DatabaseConnection(
        WasmDatabase(
          sqlite3: sqlite,
          path: 'cuentas_claras.sqlite',
          fileSystem: fileSystem,
        ),
      );
    }),
  );
}
