import 'package:arc_bloc_app/services/auth_service.dart';
import 'package:arc_bloc_app/ui/counter/bloc/counter_bloc.dart';
import 'package:arc_bloc_app/ui/login/bloc/login_bloc.dart';
import 'package:arc_bloc_app/ui/login/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LoginBloc(authService: AuthService())),
        BlocProvider(create: (context) => CounterBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Bloc Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
