import 'dart:ui';
import 'package:fake_icon/notchDisplay.dart';
import 'package:fake_icon/setting_put_icon/setting_put_icon_model.dart';
import 'package:fake_icon/shared_preference_method.dart';
import 'package:fake_icon/utils.dart';
import 'package:flutter/material.dart';
import 'package:fake_icon/position_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fake_icon/reusable_move_icon.dart';

class SettingPutIconPage extends StatelessWidget {
  Position settingIconPosition = Utils.settingPosition;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingPutIconModel>(
      create: (_) => SettingPutIconModel(),
      builder: (context, snapshot){
        return Scaffold(
          body: Consumer<SettingPutIconModel>(
            builder: (context, model, child){
              model.displaySize = MediaQuery.of(context).size;
              return dragArea(context, model);
            },
          ),
        );
      },
    );
  }

  Widget dragArea(context, model){
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Utils.backgroundImageFile == null
              ? Image.asset("images/tutorial-default-bg.png", fit: BoxFit.fill,)
              : Image.file(Utils.backgroundImageFile!, fit: BoxFit.fill,)
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 1,
            sigmaY: 1,
          ),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Utils.addNotch ? const NotchDisplay() : const SizedBox(),
        ReusableMoveIcon(
          x: Utils.splashPosition.x,
          y: Utils.splashPosition.y,
          icon: FontAwesomeIcons.ship,
          iconColor: Colors.grey,
          iconBackgroundColor: Colors.black,
          onDragEnd: (dragDetails){
            model.dragEnd(dragDetails, Utils.splashPosition);
          },
        ),
        ReusableMoveIcon(
          x: Utils.settingPosition.x,
          y: Utils.settingPosition.y,
          icon: FontAwesomeIcons.gear,
          iconColor: Colors.grey,
          iconBackgroundColor: Colors.black,
          onDragEnd: (dragDetails){
            model.dragEnd(dragDetails, Utils.settingPosition);
            print(Utils.settingPosition.y);
            },
        ),
        Positioned(
          left: Utils.completeButton.x,
            top: Utils.completeButton.y,
            child: Draggable(
              feedback: Opacity(
                opacity: 0.5,
                child: Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20.0,
                        height: 35.0,
                      ),
                      const Icon(Icons.more_vert,
                      color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            },
                          child: const Text(
                            '完了',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                      const SizedBox(width: 30.0),
                    ],
                  ),
                ),
              ),
              childWhenDragging: Container(),
              onDragEnd: (dragDetails){
                model.dragEnd(dragDetails, Utils.completeButton);
              },
              child: Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20.0,
                      height: 35.0,
                    ),
                    const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    TextButton(onPressed: () async {
                      await SharedPreferenceMethod.saveSettingIconPosition();
                      Navigator.pop(context);
                      },
                        child: const Text(
                            '完了',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ),
                    const SizedBox(width: 30.0,)
                  ],
                ),
              ),
            ),
        ),
      ],
    );
  }
}
