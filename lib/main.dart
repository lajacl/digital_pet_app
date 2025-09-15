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
    final tabs = ['My Pet', 'Tab 2', 'Tab 3', 'Tab 4'];
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
              'Flutter Text',
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
                      title: const Text('Alert Dialog'),
                      content: const Text('This is an alert from Tab 1.'),
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
              child: Text('Click for alert'),
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
      color: Colors.purple,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('SnackBar activated in 3rd tab!')),
            );
          },
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          child: Text('Click me'),
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
          ListTile(title: Text('ListTile 1')),
          ListTile(title: Text('ListTile 2')),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Map (ListTile with Image)'),
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Album (ListTile with Image)'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone (ListTile with Image)'),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsetsGeometry.all(16.0),
              child: Center(child: Text('Card 1')),
            ),
          ),
          Card(
            color: Colors.tealAccent,
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsetsGeometry.all(16.0),
              child: Center(child: Text('Card 2')),
            ),
          ),
        ],
      ),
    );
  }
}
