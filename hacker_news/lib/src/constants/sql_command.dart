class SqlCommand {
  const SqlCommand._();

  static const items = 'items';

  static String get createTableItems => '''
    CREATE TABLE IF NOT EXISTS $items(
      id INTEGER PRIMARY KEY,
      type TEXT,
      by TEXT,
      time INTEGER,
      text TEXT,
      parent INTEGER,
      kids BLOB,
      dead INTEGER,
      deleted INTEGER,
      url TEXT,
      score INTEGER,
      title TEXT,
      descendants INTEGER
    );
    ''';
}
