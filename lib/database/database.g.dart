// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MainDao? _mainDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NoteEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `date` TEXT, `description` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MainDao get mainDao {
    return _mainDaoInstance ??= _$MainDao(database, changeListener);
  }
}

class _$MainDao extends MainDao {
  _$MainDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _noteEntityInsertionAdapter = InsertionAdapter(
            database,
            'NoteEntity',
            (NoteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'date': item.date,
                  'description': item.description
                }),
        _noteEntityUpdateAdapter = UpdateAdapter(
            database,
            'NoteEntity',
            ['id'],
            (NoteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'date': item.date,
                  'description': item.description
                }),
        _noteEntityDeletionAdapter = DeletionAdapter(
            database,
            'NoteEntity',
            ['id'],
            (NoteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'date': item.date,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NoteEntity> _noteEntityInsertionAdapter;

  final UpdateAdapter<NoteEntity> _noteEntityUpdateAdapter;

  final DeletionAdapter<NoteEntity> _noteEntityDeletionAdapter;

  @override
  Future<List<NoteEntity>> getAllNotes() async {
    return _queryAdapter.queryList('SELECT * FROM NoteEntity',
        mapper: (Map<String, Object?> row) => NoteEntity(
            id: row['id'] as int?,
            title: row['title'] as String?,
            date: row['date'] as String?,
            description: row['description'] as String?));
  }

  @override
  Future<void> insertNote(NoteEntity noteEntity) async {
    await _noteEntityInsertionAdapter.insert(
        noteEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNote(NoteEntity noteEntity) async {
    await _noteEntityUpdateAdapter.update(noteEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteNote(NoteEntity noteEntity) async {
    await _noteEntityDeletionAdapter.delete(noteEntity);
  }
}
