import 'package:education/templates/lab5/comment.dart';
import 'package:education/templates/lab5/post.dart';
import 'package:education/templates/lab5/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}

TextEditingController textController = TextEditingController();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Map<String, String> routes = {
    '/': '/',
    '/generated': '/generated',
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/': (context) => const MainScreen(),
        },
        onGenerateRoute: (settings) {
          if (routes.containsKey(settings.name)) {
            return MaterialPageRoute(
                builder: (context) =>
                    MainScreen());
          }
          final name = settings.name ?? '';
          
          if (name.contains('/generated')) {
           
            return MaterialPageRoute(
                builder: (context) =>
                    CatStatusCodePage(statusCode: settings.name!));
          }
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => const UndefinedPage());
        });
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter text',
              ),
              controller: textController,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                    '/generated/${textController.text}',
                    arguments: textController.text);
              },
              child: const Text("Open cats"),
            ),
          ],
        ),
      ),
    );
  }
}


class UndefinedPage extends StatelessWidget {
  const UndefinedPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Undefined page'),
      ),
    );
  }
}


class CatStatusCodePage extends StatelessWidget {
  final String statusCode;
  const CatStatusCodePage({Key? key, required this.statusCode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final uri = 'https://http.cat/${statusCode.split('/').last}';
    return Scaffold(
      appBar: AppBar(
        title: Text('Status code: $statusCode'),
      ),
      body: Center(
        child: Image.network(uri),
      ),
    );
  }
}
