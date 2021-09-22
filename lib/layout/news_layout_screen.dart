import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/news_screens/cubit/cubit.dart';
import 'package:news_app/modules/news_screens/cubit/states.dart';
import 'package:news_app/modules/news_screens/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();

class newsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,newsStates>(
      listener: (context, state){},
      builder: (context,state){
        NewsCubit cubit = NewsCubit.getInstance(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("news app"),
            actions: [
              IconButton(
                  onPressed: (){
                    NavgPushTo(context,
                      searchScreen(),
                    );
                  },
                  icon: const Icon(Icons.search)
              ),
              IconButton(
                  onPressed: (){
                    AppCubit.getInstance(context).changeDarkTheme();
                    CacheHelper.putIsDark(key: "isDark",
                        value: AppCubit.getInstance(context).isDark
                    );

                  },
                  icon: const Icon(Icons.brightness_6)
              )

            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business_sharp),
                  label: "Business"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_volleyball_rounded),
                label: "Sports",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science),
                  label: "Science"
              ),
            ],
            currentIndex: cubit.currNavIndex ,
            onTap: (int index){
              cubit.changeNavBarIndex(index);
            },
          ),
          // floatingActionButton: FloatingActionButton(
          //   child: const Icon(Icons.add),
          //   onPressed: (){
          //     DioHelper.getData(
          //       url: 'v2/top-headlines',
          //       query:
          //       {
          //         'country':'eg',
          //         'category':'business',
          //         'apiKey':'b7d0c7fbf578454297910549ae493772',
          //       },
          //     ).then((value) {
          //       print(value.data["articles"][0]["title"]);
          //       print(value.data.toString());
          //     }).
          //     catchError((error){
          //       print(error);
          //     });
          //   },
          // ),

          body: cubit.newsScreensIndex[cubit.currNavIndex],

        );
      },
    );

  }

}