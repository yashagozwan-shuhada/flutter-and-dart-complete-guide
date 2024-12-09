import 'package:dart_testing/src/user_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
import 'user_repository_test.mocks.dart';

void main() {
  group('UserRepository', () {
    late final UserRepository repository;

    setUpAll(() {
      repository = MockUserRepository();
    });

    test('should return name when getName is called', () async {
      when(repository.getName()).thenAnswer((_) => Future.value('John Doe'));
      expect(await repository.getName(), 'John Doe');
    });

    test('should return list of friend name when get friends is called',
        () async {
      when(repository.getFriends()).thenAnswer(
        (realInvocation) => Future.delayed(
          Duration(milliseconds: 2000),
          () => ['Maria', 'Marie', 'Aira'],
        ),
      );

      expect(await repository.getFriends(), ['Maria', 'Marie', 'Aira']);
    });
  });
}
