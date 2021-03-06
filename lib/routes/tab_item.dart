import 'package:flutter/material.dart';

enum TabItem { map,checklist, help, profile }

const Map<TabItem, String> tabName = {
  TabItem.map: 'Map',
  TabItem.checklist: 'Checklist',
  TabItem.help: 'Help',
  TabItem.profile: 'Profile',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.map: Colors.blue,
  TabItem.checklist: Colors.blue,
  TabItem.help: Colors.blue,
  TabItem.profile: Colors.blue,
};

Map<TabItem, IconData> tabIcon= {
  TabItem.map: Icons.location_on,
  TabItem.checklist: Icons.checklist,
  TabItem.help: Icons.help_outline,
  TabItem.profile: Icons.person_outline,
};