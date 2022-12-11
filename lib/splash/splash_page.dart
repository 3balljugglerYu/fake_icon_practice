import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fake_icon_practice/splash/splash_model.dart';
import 'package:fake_icon_practice/utils.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SplashModel>(
        builder: (BuildContext context, model, Widget? child){
          return Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Utils.backgroundImageFile == null
                    ? Image.asset('images/splash-app-1.png')
                    : Image.file(Utils.backgroundImageFile!,
                fit: BoxFit.fill,
                ),
              ),
              
            ],
          );
        },
      ),
    );
  }
}
