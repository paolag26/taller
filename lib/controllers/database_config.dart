import 'package:sist_prestamo/controllers/local_data_client.dart';
import 'package:sist_prestamo/database/database.dart';

class DatabaseConfig {
  DatabaseConfig._();

  static AppDatabase? _database;
  static LocalDataClient? _client;
  static Future<void>? _initializing;

  static AppDatabase get database {
    final instance = _database;
    if (instance == null) {
      throw StateError('La base de datos local aun no fue inicializada.');
    }
    return instance;
  }

  static LocalDataClient get client {
    final instance = _client;
    if (instance == null) {
      throw StateError('El cliente local aun no fue inicializado.');
    }
    return instance;
  }

  static Future<void> initialize() async {
    if (_client != null) return;
    final running = _initializing;
    if (running != null) return running;

    _initializing = _initialize();
    try {
      await _initializing;
    } finally {
      _initializing = null;
    }
  }

  static Future<void> _initialize() async {
    final db = _database ?? AppDatabase();
    _database = db;
    LocalDatabaseRegistry.instance = db;
    final localClient = _client ?? LocalDataClient.create(db);
    _client = localClient;
    await localClient.ensureReady();
  }
}
