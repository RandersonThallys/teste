import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/modules/dashboard/bloc/home_bloc.dart';
import 'package:pokedex/src/modules/dashboard/bloc/states/home_state.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocBuilder<HomeBloc, HomeStates>(
        bloc: Modular.get<HomeBloc>(),
        builder: (context, state){
          return MaterialApp.router(
            title: 'Pokedex',
            themeMode: state is LightState ? ThemeMode.light : ThemeMode.dark,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorSchemeSeed: Colors.red,
            ),
            theme: ThemeData(
              brightness: Brightness.light,
              useMaterial3: false,
              colorSchemeSeed: Colors.red,
            ),
            routerDelegate: Modular.routerDelegate,
            routeInformationParser: Modular.routeInformationParser,
          );
        },
      )
    );
  }
}