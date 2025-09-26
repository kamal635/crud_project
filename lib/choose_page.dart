import 'package:crud_project/api/dio_client.dart';
import 'package:crud_project/todos/bloc/cubit/todo_cubit.dart';
import 'package:crud_project/todos/repo/todos_repository_impl.dart';
import 'package:crud_project/todos/view/widgets/todos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:crud_project/todos/view/widgets/todos_riverpod_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoosePage extends StatelessWidget {
  const ChoosePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChooseCard(
              title: "Bloc",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (context) => TodoCubit(
                        TodosRepositoryImpl(dio: DioClient.create()),
                      ),
                      child: const TodosBlocView(),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ChooseCard(
              title: "Riverpod",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TodosRiverpodView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseCard extends StatelessWidget {
  const ChooseCard({super.key, required this.title, this.onTap});
  final String title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(title, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
