import 'package:flutter/material.dart';

class GlobalNavigationRail extends StatefulWidget {
  const GlobalNavigationRail({Key? key}) : super(key: key);
  _NavigationRailExampleState createState() => _NavigationRailExampleState();
}

class _NavigationRailExampleState extends State<GlobalNavigationRail> {
  int _selectedIndex = 0;

  bool extended = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntrinsicWidth(
        child: NavigationRail(
          selectedIndex: _selectedIndex,
          destinations: _buildDestinations(),
          extended: extended,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  List<NavigationRailDestination> _buildDestinations() {
    return [
      NavigationRailDestination(
        icon: InkWell(
          onTap: () {
            setState(() => extended = !extended);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("App"),
              Icon(extended ? Icons.arrow_right : Icons.arrow_left)
            ],
          ),
        ),
        label: Container(
          width: 0,
        ),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.save),
        label: Text('Save'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.favorite),
        label: Text('Favorites'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.map),
        label: Text('Show on Map'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.logout),
        label: Text('Logout'),
      ),
    ];
  }
}
