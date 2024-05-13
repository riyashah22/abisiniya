import 'package:flutter/material.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Cars'),
                Tab(text: 'Bus'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Content of the first tab (Cars)
                  Container(
                    child: Row(
                      children: [Image(image: NetworkImage("url"))],
                    ),
                  ),
                  // Content of the second tab (Bus)
                  Container(
                    child: Center(
                      child: Text('Bus Tab Content'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
