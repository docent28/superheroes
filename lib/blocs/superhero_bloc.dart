import 'package:http/http.dart' as http;

class SuperheroBloc {
  http.Client? client;
  final String id;

  SuperheroBloc({this.client, required this.id}) {}

  void dispose() {
    client?.close();
  }
}
