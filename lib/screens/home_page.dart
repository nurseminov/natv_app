import 'package:flutter/material.dart';
import 'package:natv_app/screens/banner_tab.dart';
import 'package:natv_app/screens/ticker_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
                controller: _tabController,
                indicator: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Color.fromARGB(255, 135, 24, 52),
                            width: 5))),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: const Color.fromARGB(255, 135, 24, 52),
                unselectedLabelColor: const Color(0xFFC0C0C0),
                tabs: <Widget>[
                  Tab(
                    height: 75,
                    child: Text(
                      'Размещение строчного объявления'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Tab(
                    height: 75,
                    child: Text(
                      'Размещение баннерной рекламы'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ]),
            Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: const <Widget>[TickerAdTab(), BannerAdTab()]),
            )
          ],
        ),
      ),
    );
  }
}
