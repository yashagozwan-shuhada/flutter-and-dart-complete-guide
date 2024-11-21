// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mysql_client/mysql_client.dart' as _i62;
import 'package:sources/core/module/register_module.dart' as _i622;
import 'package:sources/data/repository/book_repository_impl.dart' as _i794;
import 'package:sources/data/source/local/book_local_data_source.dart' as _i593;
import 'package:sources/domain/repository/book_repository.dart' as _i140;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.lazySingletonAsync<_i62.MySQLConnection>(
      () => registerModule.mySqlConnection,
      preResolve: true,
    );
    gh.lazySingleton<_i593.BookLocalDataSource>(
        () => _i593.BookLocalDataSource(gh<_i62.MySQLConnection>()));
    gh.lazySingleton<_i140.BookRepository>(
        () => _i794.BookRepositoryImpl(gh<_i593.BookLocalDataSource>()));
    return this;
  }
}

class _$RegisterModule extends _i622.RegisterModule {}
