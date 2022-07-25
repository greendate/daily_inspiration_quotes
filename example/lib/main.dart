import 'dart:async';
import 'dart:convert';

import 'package:daily_inspiration_quotes/daily_inspiration_quotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Todo.dart';
import 'bloc/api_bloc.dart';
import 'bloc/api_states.dart';
import 'bloc/api_events.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.deepPurple,
              accentColor: Colors.deepOrangeAccent)),
      home: BlocProvider(
        create: (_) => ApiBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List"),
      ),
      // Calling the Quote buttonm giving canvas, text colors, button icon and its color as an input
      floatingActionButton: QuoteDialogButton(
        canvasColor: Colors.amber.shade200,
        textColor: Colors.black45,
        buttonIcon: Icons.lightbulb_circle_rounded,
        buttonColor: Colors.amber,
      ),
      body: buildBloc(),
    );
  }

  Widget buildBloc() {
    return BlocBuilder<ApiBloc, ApiStates>(builder: (context, state) {
      if (state is InitialState) {
        return buildInitialView();
      }
      if (state is LoadingState) {
        // Instead of just showing progress indicator in the loading state
        // We are displaying QuoteLoadingScreen and giving it canvas and text colors as and input
        return QuoteLoadingScreen(
          canvasColor: Colors.amber.shade200, 
          textColor: Colors.black45
        );
      }
      if (state is SuccessUserList) {
        List<Todo> users = state.usersList;
        return buildUserList(users);
      }
      if (state is FailureState) {
        return const Center(child: Text("Error while Connecting"));
      }

      return const Text("Nothing");
    });
  }

  Center buildInitialView() {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            context.read<ApiBloc>().add(getTodosEvents());
          },
          child: Text("Get TODO".toUpperCase())),
    );
  }

  Widget buildUserList(List<Todo> users) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 5), () {});
      },
      child: RefreshIndicator(
        onRefresh: () {
          return Future.value(true);
        },
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const Icon(Icons.today_outlined),
                title: Text("${users[index].title}"),
                trailing: users[index].completed
                    ? Icon(
                        Icons.done,
                        color: Colors.green,
                      )
                    : null,
              );
            }),
      ),
    );
  }
}

class User {
  late int id;
  late String name;
  late String email;
  late String status;
  late String gender;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    gender = json['gender'];
  }
}
