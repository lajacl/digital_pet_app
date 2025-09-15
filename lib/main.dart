import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(length: 4, child: _TabsNonScrollableDemo()),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  final RestorableInt tabIndex = RestorableInt(0);
  @override
  String get restorationId => 'tab_non_scrollable_demo';
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For the To do task hint: consider defining the widget and name of the tabs here
    final tabs = ['My Pet', 'Feed', 'Play', 'Tracker'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tabs & Widgets'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [for (final tab in tabs) Tab(text: tab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // hint for the to do task:Considering creating the different for different tabs
          // for (final tab in tabs) Center(child: Text(tab)),
          TabContentOne(),
          TabContentTwo(),
          TabContentThree(),
          TabContentFour(),
        ],
      ),
    );
  }
}

class TabContentOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: Center(
        child: Image.network(
          'https://png.pngtree.com/png-vector/20250130/ourmid/pngtree-smiling-cartoon-dog-with-floppy-ears-png-image_15374987.png',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}

class TabContentTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          children: [
            Text(
              'Your pet is hungry',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('YUM!'),
                      content: const Text('Your pet was fed!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Click to Feed'),
            ),
          ],
        ),
      ),
    );
  }
}

class TabContentThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.network(
          'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA4L2pvYjk1Mi0wNTQuanBn.jpg',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}

class TabContentFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.sentiment_satisfied),
            title: Text('Sunday'),
          ),
          ListTile(
            leading: Icon(Icons.sentiment_dissatisfied),
            title: Text('Monday'),
          ),
          ListTile(
            leading: Icon(Icons.sentiment_neutral),
            title: Text('Tuseday'),
          ),
          ListTile(
            leading: Icon(Icons.sentiment_satisfied),
            title: Text('Wednesday'),
          ),
          ListTile(
            leading: Icon(Icons.sentiment_dissatisfied),
            title: Text('Thursday'),
          ),
          ListTile(
            leading: Icon(Icons.sentiment_neutral),
            title: Text('Friday'),
          ),
          ListTile(
            leading: Icon(Icons.sentiment_neutral),
            title: Text('Satuday'),
          ),
        ],
      ),
    );
  }
}
