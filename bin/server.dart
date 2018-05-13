import 'dart:io';
import 'dart:async';
import 'package:http_server/http_server.dart';


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
          } else if (request.uri.path == '/add') {
      try {           new File('data/file.txt',mode:  FileMode.APPEND ).writeAsString('Dart is awsome!<br/>')
    .then((File file) {
       request.response.headers..contentType = ContentType.TEXT;
            request.response
                ..writeln('Added msg to file');
// Do something with the file.
    }); } catch(e) { request.response.redirect(request.uri.resolve('/index.html'));}
          } else if (request.uri.path == '/list') {
            new File('data/file.txt').readAsString().then((String contents) {
            request.response
                ..writeln(contents); });
          }
          else {
            webFiles.serveRequest(request);
          }
      });
    });
  },
  onError: (e, stackTrace) {
    print('Error processing request $e\n$stackTrace');
  });
}

