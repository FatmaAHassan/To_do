import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/my_provider.dart';


class ButtonSheetThem extends StatelessWidget {
  const ButtonSheetThem({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Container(
      color: pro.themeMode == ThemeMode.light
          ? Colors.white
          : Theme
          .of(context)
          .primaryColor,
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              pro.changeThem(ThemeMode.light);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Light',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                        color: pro.themeMode == ThemeMode.light
                            ? Theme
                            .of(context)
                            .primaryColor
                            : Colors.white),
                  ),
                  Spacer(),
                  Icon(
                    Icons.done,
                    // color: pro.themeMode == ThemeMode.light
                    //     ? MyThemeData.primaryColor
                    //     : Colors.white,
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 2,
            thickness: 2,
            color: Color(0xFFB7935F),
            endIndent: 50,
            indent: 50,
          ),
          InkWell(
            onTap: () {
              pro.changeThem(ThemeMode.dark);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Dark',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(

                    ),

                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}