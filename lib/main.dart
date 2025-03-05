import 'package:flutter/material.dart';
import 'joke_card.dart';
import 'joke_service.dart';
import 'joke_model.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final JokeService _jokeService = JokeService();
  List<Joke> _jokes = [];

  @override
  void initState() {
    super.initState();
    _fetchJokes();
  }

  Future<void> _fetchJokes() async {
    try {
      final jokes = await _jokeService.fetchJokes();
      setState(() {
        _jokes = jokes;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _handleRefresh() async {
    await _fetchJokes();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Joke App'),
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.black,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              child: const Column(
                children: [
                  Text(
                    'Welcome to the Joke App!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Pull to refresh or click the button below to generate a new joke.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: LiquidPullToRefresh(
                onRefresh: _handleRefresh,
                color: Colors.yellow,
                backgroundColor: Colors.white,
                height: screenHeight * 0.5,
                child: ListView.separated(
                  itemCount: _jokes.length,
                  itemBuilder: (context, index) {
                    final joke = _jokes[index];
                    final title = joke.type == 'single' ? joke.joke : joke.setup;
                    final subtitle = joke.type == 'twopart' ? joke.delivery : '';
                    final tag = joke.category;

                    return Container(
                      margin: EdgeInsets.only(left: 16.0, right: 16.0), // Add margin to the Card
                      child: CardExample(
                        title: title,
                        subtitle: subtitle,
                        tag: tag,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 20.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _handleRefresh,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(200, 50),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Fetch Jokes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}