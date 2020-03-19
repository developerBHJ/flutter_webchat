import 'package:flutter/material.dart';
import 'dart:ui';

//主题色
final Color ThemeColor = Color.fromRGBO(223, 223, 223, 1.0);

//屏幕的宽高
double ScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double ScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;
// 获取状态栏高度
double StatusBarHeight(BuildContext context) => MediaQueryData.fromWindow(window).padding.top;
