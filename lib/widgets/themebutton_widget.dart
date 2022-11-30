import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walldex_app/utils/coolor.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      margin: const EdgeInsets.only(right: 11),
      child: Switch.adaptive(
        activeColor: Theme.of(context).primaryColor.withOpacity(0.3),
        activeTrackColor: Colors.white,
        inactiveThumbColor: Theme.of(context).primaryColor.withOpacity(0.3),
        inactiveTrackColor: Colors.black,
        value: themeProvider.isDarkMode,
        onChanged: (value) {
          final provider = Provider.of<ThemeProvider>(context,listen: false);
          provider.toggleTheme(value);
        },
      ),
    );
  }
}