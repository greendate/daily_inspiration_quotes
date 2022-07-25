import 'dart:convert';
import 'dart:io';
import 'api_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'api_states.dart';
import '../Todo.dart';

class ApiBloc extends Bloc<ApiEvents, ApiStates> {
  ApiBloc() : super(InitialState()) {
    on<getTodosEvents>(_getTodos);
  }

  _getTodos(ApiEvents event, Emitter<ApiStates> emitter) async {
    try {
      emitter(LoadingState());
      List<Todo> users = await getTodos();
      emitter(SuccessUserList(users));
    } catch (e) {
      print(e);
      emitter(FailureState());
    }
  }

  Future<List<Todo>> getTodos() async {
    List<Todo> todo = [];
    // Repeat http.get several times to have longer lasting LoadingState
    Response response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    for (int i = 0; i < 120; i++) {
      response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    }
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      body.forEach((json) {
        todo.add(Todo.fromJson(json));
      });
      return todo;
    }
    return [];
  }
}
