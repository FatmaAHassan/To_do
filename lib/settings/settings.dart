import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/settings/buttom_sheet_them.dart';
import 'package:to_do/settings/buttom_sheete_lang.dart';

import '../providers/my_provider.dart';

class SettingsTap extends StatefulWidget {
  const SettingsTap({super.key});

  @override
  State<SettingsTap> createState() => _SettingsTapState();
}

class _SettingsTapState extends State<SettingsTap> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    var lang = pro.changeLanguage;

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Language',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          InkWell(
            onTap: () {
              showButtonSheetLanguage(context);
            },
            child: Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Text(
                pro.language == 'ar' ? 'Arabic' : 'English',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Themes',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          InkWell(
            onTap: () {
              showButtonSheetThem(context);
            },
            child: Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Text(
                pro.themeMode == ThemeMode.light ? 'Light' : 'Dark',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  showButtonSheetLanguage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ButtonSheetLang();
      },
    );
  }

  showButtonSheetThem(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ButtonSheetThem();
      },
    );
  }
}
