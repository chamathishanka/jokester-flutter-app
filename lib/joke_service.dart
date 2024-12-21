import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'joke_model.dart';

class JokeService {
  static const String _url = 'https://v2.jokeapi.dev/joke/Programming,Miscellaneous,Pun,Christmas?blacklistFlags=nsfw,explicit&amount=5';
  final Dio _dio = Dio();

  Future<List<Joke>> fetchJokes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await _dio.get(_url);

      if (response.statusCode == 200) {
        final List<dynamic> jokeList = response.data['jokes'];
        final jokes = jokeList.map((json) => Joke.fromJson(json)).toList();
        await _cacheJokes(jokes);
        return jokes;
      } else {
        throw Exception('Failed to load jokes');
      }
    } catch (e) {
      return await _loadCachedJokes();
    }
  }

  Future<void> _cacheJokes(List<Joke> jokes) async {
    final prefs = await SharedPreferences.getInstance();
    final jokesJson = jsonEncode(jokes.map((joke) => joke.toJson()).toList());
    await prefs.setString('cached_jokes', jokesJson);
  }


  Future<List<Joke>> _loadCachedJokes() async {
    final prefs = await SharedPreferences.getInstance();
    final jokesJson = prefs.getString('cached_jokes');
    if (jokesJson != null) {
      final List<dynamic> jokesList = jsonDecode(jokesJson);
      return jokesList.map((json) => Joke.fromJson(json)).toList();
    } else {
      throw Exception('No cached jokes available');
    }
  }

}