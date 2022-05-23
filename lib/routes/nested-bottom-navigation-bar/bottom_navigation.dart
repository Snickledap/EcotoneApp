import 'package:flutter/material.dart';
import 'package:ecotone_app/routes/nested-bottom-navigation-bar/tab_item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({required this.currentTab, required this.onSelectTab});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: [
          _buildItem(TabItem.map),
          _buildItem(TabItem.checklist),
          _buildItem(TabItem.help),
          _buildItem(TabItem.profile)
        ],
        onTap: (index) =>
            onSelectTab(
              TabItem.values[index],
            ),
        currentIndex: currentTab.index,
        selectedItemColor: activeTabColor[currentTab]!,
        selectedLabelStyle: TextStyle(color: Colors.orange)
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      backgroundColor: Colors.black,
      icon: Icon(tabIcon[tabItem],
        color: _colorTabMatching(tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  Color _colorTabMatching(TabItem item) {
    return currentTab == item ? activeTabColor[item]! : Colors.white;
  }
}