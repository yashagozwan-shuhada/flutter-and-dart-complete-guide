import 'package:mysql_client/mysql_client.dart';

final pool = MySQLConnection.createConnection(
  host: 'localhost',
  port: 3306,
  userName: 'root',
  password: 'password',
);
