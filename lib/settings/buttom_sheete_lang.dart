import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/my_provider.dart';

class ButtonSheetLang extends StatelessWidget {
  const ButtonSheetLang({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (pro.changeLanguage == "en") {
                return;
              }
              pro.changeLanguage("en");
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Arabic',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: pro.language != 'en'
                            ? Theme.of(context).primaryColor
                            : Colors.black),
                  ),
                  Spacer(),
                  Icon(
                    Icons.done,
                    // color: pro.language == 'ar'
                    //     ? MyThemeData.primaryColor
                    //     : Colors.black,
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
              if (pro.changeLanguage != "en") {
                return;
              }
              pro.changeLanguage("ar");
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'English',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: pro.language != 'ar'
                            ? Theme.of(context).primaryColor
                            : Colors.black),
                  ),
                  Spacer(),
                  Icon(
                    Icons.done,
                    // color: pro.language != 'ar'
                    //     ? MyThemeData.primaryColor
                    //     : Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
