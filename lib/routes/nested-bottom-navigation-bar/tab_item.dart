import 'package:flutter/material.dart';

enum TabItem { amber, green, blue }

const Map<TabItem, String> tabName = {
  TabItem.amber: 'Map',
  TabItem.green: 'Checklist',
  TabItem.blue: 'Account Profile',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.amber: Colors.amber,
  TabItem.green: Colors.green,
  TabItem.blue: Colors.blue,
};