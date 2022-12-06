import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'setting_top_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingTopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //データが変わったことを知りWidgetを作り直す。ChangeNotifierProvider
    return ChangeNotifierProvider<SettingTopModel>(
      create: (_) => SettingTopModel(),
      builder: (context, model){
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Opacity(
              opacity: 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Icon(
                    FontAwesomeIcons.gears,
                    size: 35,
                    color: Colors.black,
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    '設定',
                    style: TextStyle(fontSize: 24,color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
