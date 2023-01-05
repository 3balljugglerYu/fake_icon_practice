import 'dart:ui';
import 'package:fake_icon_practice/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fake_icon_practice/fake/fake_model.dart';
import 'package:fake_icon_practice/performance/performance_page.dart';

class FakePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => FakeModel(),
        child: Consumer<FakeModel>(
          builder: (BuildContext context, model, Widget? child, ){
            model.displaySize = MediaQuery.of(context).size;
            model.toPerformancePage = () async {
              await Future.delayed(const Duration(milliseconds: 200));
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      PerformancePage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(child: child, opacity: animation);
                  },
                ),
              );
            };
            return Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Utils.backgroundImageFile == null ? Image.asset('images/performance-page.jpg',
                  fit: BoxFit.fill,
                  ) : Image.file(Utils.backgroundImageFile!,
                  fit: BoxFit.fill,
                  ),
                ),
                BackdropFilter(filter: ImageFilter.blur(
                  sigmaX: 15,
                  sigmaY: 15,
                ),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onLongPress: model.onLongPress,
                    onVerticalDragStart: model.onVerticalDragStart,
                    onVerticalDragUpdate: model.onVerticalDragUpdate,
                    onVerticalDragEnd: model.onVerticalDragEnd,
                    child: Container(
                      child: AnimatedContainer(
                        curve: Curves.easeOutQuint,
                        duration: Duration(milliseconds: model.imageAnimationDuration),
                        transform: model.imageTransform,
                        child: ClipRRect(
                          borderRadius: model.borderRadius,
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Utils.fakeBackgroundImageFile == null ? Image.asset('images/default_fake_page.png',
                            fit: BoxFit.fill,
                            ) : Image.file(
                              Utils.fakeBackgroundImageFile!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
