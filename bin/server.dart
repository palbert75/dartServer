import 'dart:io';
import 'dart:async';
import 'package:http_server/http_server.dart';

void returnIndexFile(HttpRequest request, String msg, String content) {
  request.response.headers..contentType = ContentType.HTML;
  request.response
    ..writeln('<!DOCTYPE html>')
    ..writeln('<html>')
    ..writeln('<head>')
    ..writeln("<link rel='stylesheet' href='index.css'>")
    ..writeln("</head>")
    ..writeln("<body>")
    ..writeln("<h1>Hello from Dart server</h1>")
    ..writeln("<p><a href='/'>Home</a></p>")
    ..writeln("<p><a href='/add'>Add messages</a></p>")
    ..writeln("<p><a href='/delete'>Delete messages</a></p>")
    ..writeln("<p><a href='/version'>Server version</a></p>")
    ..writeln("$msg\n<hr>")
    ..writeln("<div><p>$content</p></div>")
    ..writeln("</body>")
    ..writeln("</html>")
    ..close();
}

void main() {
  var webFiles = new VirtualDirectory('web');

  runZoned(() {
    HttpServer.bind('0.0.0.0', 8080).then((server) {
      server.listen((request) {
        if (request.uri.path == '/') {
          try {
            File file = new File('data/file.txt');
            file.createSync();
            file.readAsString().then((String contents) {
              returnIndexFile(
                  request, 'File size=${contents.length}', contents);
            });
          } catch (e) {
            print(e);
            returnIndexFile(request, 'No messages found', '');
          }
        } else if (request.uri.path == '/version') {
          request.response.headers..contentType = ContentType.TEXT;
          request.response
            ..writeln('Dart version: ${Platform.version}')
            ..writeln('Dart executable: ${Platform.executable}')
            ..writeln('Dart executable arguments: '
                '${Platform.executableArguments}')
            ..close();
        } else if (request.uri.path == '/add') {
          try {
            new File('data/file.txt')
                .writeAsString('Dart is awsome!<br/>\n', mode: FileMode.APPEND)
                .then((File file) {
              file.readAsString().then((String contents) {
                returnIndexFile(
                    request, 'File size=${contents.length}', contents);
              });
            });
          } catch (e) {}
        } else if (request.uri.path == '/delete') {
          new File('data/file.txt').deleteSync();
          returnIndexFile(request, 'File has been deleted', '');
        } else {
          webFiles.serveRequest(request);
        }
      });
    });
  }, onError: (e, stackTrace) {
    print('Error processing request $e\n$stackTrace');
  });
}
