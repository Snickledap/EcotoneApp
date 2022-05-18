import 'package:flutter/material.dart';

enum TabItem { amber, green, blue }

const Map<TabItem, String> tabName = {
  TabItem.amber: 'red',
  TabItem.green: 'green',
  TabItem.blue: 'blue',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.amber: Colors.amber,
  TabItem.green: Colors.green,
  TabItem.blue: Colors.blue,
};