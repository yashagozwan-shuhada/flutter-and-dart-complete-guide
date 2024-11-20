void main() async {
  print("About to fetch data...");

  /// get("http://google.com").then(print).catchError(print);
  final result = await get("http://google.com");
  print(result);
}

Future<String> get(String url) {
  return Future.delayed(Duration(milliseconds: 3000), () => "Got the data!");
}
