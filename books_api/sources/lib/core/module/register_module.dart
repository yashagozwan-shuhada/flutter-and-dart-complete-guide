import 'package:injectable/injectable.dart';
import 'package:mysql_client/mysql_client.dart';

@module
abstract class RegisterModule {
  @preResolve
  @lazySingleton
  Future<MySQLConnection> get mySqlConnection =>
      MySQLConnection.createConnection(
        host: 'localhost',
        port: 3306,
        userName: 'root',
        password: 'password',
        databaseName: 'junior_mobile',
      );
}
