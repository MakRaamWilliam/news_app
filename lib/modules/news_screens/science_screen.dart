import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_app/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class sciencetScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,newsStates>(
      listener: (context,state){},
      builder: (context, state){
        NewsCubit cubit = NewsCubit.getInstance(context);
        return Conditional.single(
            context: context,
            conditionBuilder:(context)=> state is! NewsGetScienceSuccessState ,
            widgetBuilder: (context)=> const Center(child: CircularProgressIndicator()),
            fallbackBuilder: (context)=> articleBuilder(

              context: context,
              isSearch: true,
              list: cubit.scienceList,
            )
        );
      },
    );

  }


}