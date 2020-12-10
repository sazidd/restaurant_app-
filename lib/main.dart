import 'package:flutter/material.dart';
import 'package:flutterapptestpush/menu/bloc/menu_bloc.dart';
import 'package:flutterapptestpush/menu/repository.dart';
import 'package:flutterapptestpush/screens/home.dart';
import 'package:flutterapptestpush/screens/order_item_screen/bloc/order_item_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutterapptestpush/providers/app_provider.dart';
import 'package:flutterapptestpush/screens/splash.dart';
import 'package:flutterapptestpush/util/const.dart';
import 'util/const.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(
          create: (_) => MenuBloc(repository: Repository()),
        ),
        ChangeNotifierProvider(create: (_) => OrderItemBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: Constants.appName,
          theme: appProvider.theme,
          darkTheme: Constants.darkTheme,
          // home: SplashScreen(),
          home: Home(),
        );
      },
    );
  }
}
