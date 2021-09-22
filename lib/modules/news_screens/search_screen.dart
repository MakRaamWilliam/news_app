import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/news_screens/cubit/cubit.dart';
import 'package:news_app/modules/news_screens/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class searchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // return const Text("search SCreen");
    return BlocConsumer<NewsCubit,newsStates>(
      listener: (context,state){},
      builder: (context,state){
        NewsCubit cubit = NewsCubit.getInstance(context);
        return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children: [
              defaultFormField(
                label: "search",
                type: TextInputType.text,
                controller: searchController,
                validText: "search can not be empty!",
                onChange: (value){
                  cubit.getSearch(value);
                }
              ),
              Expanded(
                  child: articleBuilder(
                      list: cubit.searchList,
                      context: context,
                      isSearch: true
                  ),
              )
            ],
          ),
        );
      },
    );

  }

}