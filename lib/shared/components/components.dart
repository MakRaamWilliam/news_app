import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_app/modules/news_screens/webp_age_screen.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback onPressed,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defultTextForm
(
{
  required TextEditingController controller,
  required TextInputType textInputType,
  Function(String value)?  onFieldSubmitted,
  InputDecoration? decoration,
  String validText ="Can not be empty!",

})
{
return TextFormField(
        controller: controller,
        keyboardType: textInputType,
        onFieldSubmitted: onFieldSubmitted,
        validator: (value) {
          if (value!.isEmpty) {
            return validText;
          }
          return null;
        },
        decoration: decoration,
        );

}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String value)? onSubmit,
  Function(String value)? onChange,
  Function()? onTap,
  bool isPassword = false,
  required String validText,
  required String label,
  IconData? prefix,
  IconData? suffix,
  Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: (value) {
        if (value!.isEmpty) {
          return validText;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: const OutlineInputBorder(),
      ),
    );


void NavgPushTo(context,Widget widget){


    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context){
            return widget;
          },
        )
    );

}




Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 2.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(
    List<dynamic> list,
    index,
    context,
    )
{
  return InkWell(
    onTap: (){
      NavgPushTo(context, webPageScreen(url: list[index]['url']));
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(
              image: NetworkImage(
                  list[index]["urlToImage"] != null? '${list[index]["urlToImage"]}' :
                  'https://neteco.gr/wp-content/uploads/2019/09/technews.jpg'
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${list[index]["title"]} ",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1 ,
              ),
              Text( list[index]["author"] != null? "${list[index]["author"]}": "" ,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text( list[index]["publishedAt"] != null? "${list[index]["publishedAt"]}": "" ,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),

            ],
          ),
        ),

      ],
    ),
  );
}

Widget articleBuilder({
   required List<dynamic> list,
   required context,
   required isSearch,
  }
    ) =>
    Conditional.single(
      context: context,
      conditionBuilder:(context) => true,
      widgetBuilder: (context) =>
          ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildArticleItem(list,index,context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: list.length,
          ),
      fallbackBuilder: (context) => isSearch ? Container() : const Center(child: CircularProgressIndicator()),

    );