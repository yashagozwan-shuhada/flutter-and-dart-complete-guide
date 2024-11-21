import 'package:mysql_client/mysql_client.dart';
import 'package:sources/core/di/di.dart';

Future<void> runner() async {
  await configureDependencies();
  await ioc<MySQLConnection>().connect();
}
