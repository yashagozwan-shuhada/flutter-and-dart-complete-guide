abstract class UserRepository {
  Future<String> getName();

  Future<List<String>> getFriends();
}
