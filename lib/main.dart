import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_layout_screen.dart';
import 'package:news_app/modules/news_screens/cubit/cubit.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness()),
        BlocProvider(create: (context)=>AppCubit()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          bool? isDark = CacheHelper.getIsDark(key: "isDark");
          isDark ??= false;
          bool dark =isDark;

          return  MaterialApp(
            home: Directionality
              (
                textDirection: TextDirection.rtl,
                child: newsScreen()
            ),
            theme: ThemeData(

              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: Colors.white,
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(

              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: HexColor('333739'),
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

            ),
            themeMode: dark ? ThemeMode.dark : ThemeMode.light ,
          );

        },
      ),
    );
  }
}


