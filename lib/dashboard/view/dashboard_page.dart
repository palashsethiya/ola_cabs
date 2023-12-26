import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ola_cabs/dashboard/bloc/dashboard_bloc.dart';
import 'package:ola_cabs/dashboard/view/dashboard_from.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DashboardBloc(),
        child: const Scaffold(
          body: DashboardForm(),
        ));
  }
}
