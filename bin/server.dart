import 'dart:io';
import 'dart:async';
import 'package:http_server/http_server.dart';

/*main() async {

  
  var server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8080);
  print("Serving at ${server.address}:${server.port}");

  await for (var request in server) {

    request.response
      ..headers.contentType = new ContentType("text", "plain", charset: "utf-8")
      ..write('Hello, world')
      ..close();


  }
}*/


void main() {
  var webFiles = new VirtualDirectory('web');

  runZoned(() {
    HttpServer.bind('0.0.0.0', 8080).then((server) {
      server.listen((request) {
          if (request.uri.path == '/') {
            request.response.redirect(request.uri.resolve('/index.html'));
          } else if (request.uri.path == '/version') {
            request.response.headers..contentType = ContentType.TEXT;
            request.response
                ..writeln('Dart version: ${Platform.version}')
                ..writeln('Dart executable: ${Platform.executable}')
                ..writeln('Dart executable arguments: '
                          '${Platform.executableArguments}')
                ..close();
          } else {
            webFiles.serveRequest(request);
          }
      });
    });
  },
  onError: (e, stackTrace) {
    print('Error processing request $e\n$stackTrace');
  });
}

