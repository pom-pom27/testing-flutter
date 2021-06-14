import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/unit_test/mockito/api.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum -', () {
    test('return an album if the http call succeeds', () async {
      //arrange

      final client = MockClient();

      //act
      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')),
      ).thenAnswer(
        (_) async => http.Response(
          '{"userId":1,"id" : 2, "title": "asdas" }',
          200,
        ),
      );

      //assert
      expect(await fetchAlbum(client), isA<Album>());
    });

    test('throw an exception when http call completes with an error', () async {
      final client = MockClient();

      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );
      expect(fetchAlbum(client), throwsException);
    });
  });
}
