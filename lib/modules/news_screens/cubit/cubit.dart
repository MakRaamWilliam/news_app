import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/news_screens/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import '../business_screen.dart';
import '../science_screen.dart';
import '../sports_screen.dart';

class NewsCubit extends Cubit<newsStates>{
  NewsCubit() :
        super(newsInitialState());

  int currNavIndex =0;
  List<Widget> newsScreensIndex = [
    businessScreen(),
    sporstScreen(),
    sciencetScreen(),
  ];

  static NewsCubit getInstance(context) => BlocProvider.of(context);

  void changeNavBarIndex(int index){
    currNavIndex = index;
    if(index == 0) {
      getBusiness();
    } else if(index == 1) {
      getSports();
    } else if(index == 2) {
      getScience();
    }
  }

  List<dynamic> sportsList = [];
  List<dynamic> businessList = [];
  List<dynamic> scienceList = [];
  List<dynamic> searchList = [];

  void getScience(){
    emit(NewsGetScienceLoadingState());

    if(scienceList.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'science',
          'apiKey':'b7d0c7fbf578454297910549ae493772',
        },
      ).then(
              (value){
                scienceList = value.data['articles'];

                emit(newsChangeBottomNavBarState());
                emit(NewsGetScienceSuccessState());
              }
              ).catchError((error){
                // print(error);
                emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(newsChangeBottomNavBarState());
      emit(NewsGetScienceSuccessState());
    }
  }
  void getSports(){
    emit(NewsGetSportsLoadingState());

    if(sportsList.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'sports',
          'apiKey':'b7d0c7fbf578454297910549ae493772',
        },
      ).then(
              (value){
            // print(value);
            sportsList = value.data['articles'];
            // print(sportsList);
            emit(newsChangeBottomNavBarState());
            emit(NewsGetSportsSuccessState());
          }
      ).catchError((error){
        // print(error);
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(newsChangeBottomNavBarState());
      emit(NewsGetSportsSuccessState());
    }

  }
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());

    if(businessList.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'Business',
          'apiKey':'b7d0c7fbf578454297910549ae493772',
        },
      ).then(
              (value){
            businessList = value.data['articles'];

            emit(newsChangeBottomNavBarState());
            emit(NewsGetBusinessSuccessState());
          }
      ).catchError((error){
        // print(error);
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }else{
      emit(newsChangeBottomNavBarState());
      emit(NewsGetBusinessSuccessState());
    }

  }

  void getSearch(String searchValue){
    emit(NewsGetSearchLoadingState());


      DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q':searchValue,
          'apiKey':'b7d0c7fbf578454297910549ae493772',
        },
      ).then(
              (value){
            searchList = value.data['articles'];
            emit(newsChangeBottomNavBarState());
            emit(NewsGetSearchSuccessState());
          }
      ).catchError((error){
        // print(error);
        emit(NewsGetSearchErrorState(error.toString()));
      });

    }


}