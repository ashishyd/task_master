import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Master',
      color: Colors.white,
      theme: ThemeData(
          primaryColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[800], opacity: 1.0),
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white,
          accentColor: Colors.blue[700]),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> tasks = [];
  List<String> finisedTasks = [];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50.0,
          ),
          const Align(
              child: Text(
            'My Tasks',
            style: TextStyle(fontSize: 32.0, fontFamily: 'Product Sans'),
          )),
          if (tasks.isEmpty && finisedTasks.isEmpty)
            Expanded(child: Container())
          else
            Container(),
          if (tasks.isEmpty && finisedTasks.isEmpty)
            Flex(
              direction: Axis.vertical,
              children: [
                Image.asset(
                  'assets/background.png',
                  width: 250.0,
                  height: 250.0,
                ),
                const Text(
                  'A new beginning',
                  style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 18.0,
                      letterSpacing: -0.4),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Would you like to create a task?',
                  style: TextStyle(color: Colors.grey[700]),
                )
              ],
            )
          else
            Expanded(
                child: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: tasks
                      .map((task) => Dismissible(
                          key: Key(task),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            setState(() {
                              finisedTasks.add(task);
                              tasks.remove(task);
                            });
                          },
                          background: Container(
                            color: Theme.of(context).accentColor,
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading:
                                    const Icon(Icons.radio_button_unchecked),
                                title: Text(task),
                              ),
                              const Divider(
                                height: 1.0,
                              )
                            ],
                          )))
                      .toList()
                        ..addAll(finisedTasks.isEmpty
                            ? []
                            : [
                                Dismissible(
                                  key: const Key('Done'),
                                  onDismissed: (direction) {
                                    setState(() {
                                      finisedTasks = [];
                                    });
                                  },
                                  direction: DismissDirection.startToEnd,
                                  background: Container(
                                    color: Colors.red,
                                  ),
                                  child: ExpansionTile(
                                    title: Text(
                                      'Done (${finisedTasks.length})',
                                      style: const TextStyle(
                                          fontFamily: 'Product Sans',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    children: finisedTasks
                                        .map((task) => ListTile(
                                              title: Text(task),
                                              leading: const Icon(
                                                  Icons.check_circle_outline),
                                            ))
                                        .toList(),
                                  ),
                                )
                              ]),
                ))
              ],
            )),
          if (tasks.isEmpty && finisedTasks.isEmpty)
            Expanded(child: Container())
          else
            Container()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          elevation: 6.0,
          highlightElevation: 10.0,
          splashColor: Colors.white.withOpacity(0.07),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: () {
            buildNewSheet();
          },
          foregroundColor: Theme.of(context).accentColor,
          label: const Text('Add task',
              style: TextStyle(
                  fontFamily: 'Product Sans',
                  fontSize: 16.0,
                  color: Colors.white)),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 55.0 + MediaQuery.of(context).padding.bottom,
        child: Material(
          color: Colors.white,
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.grey[700],
                    ),
                    onPressed: () {
                      buildNavigationSheet();
                    }),
                IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.grey[700]),
                    onPressed: () {
                      buildOptionSheet();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void buildOptionSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              children: [
                Expanded(child: Container()),
                Material(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(6.0)),
                  child: SafeArea(
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 25.0, bottom: 10.0),
                                child: Text(
                                  'Sort By',
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 14.0),
                                ),
                              ),
                              const ListTile(
                                trailing: Icon(Icons.check),
                                title: Padding(
                                  padding: EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    'My tasks',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(left: 12.0),
                                  child: Text('Date'),
                                ),
                              ),
                              const Divider(),
                              Flex(
                                direction: Axis.vertical,
                                children: [
                                  const ListTile(
                                      title: Text('Rename List',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ))),
                                  const ListTile(
                                      title: Text('Delete List',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.grey))),
                                  ListTile(
                                    title: Text(
                                      'Delete all completed tasks',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: finisedTasks.isEmpty
                                              ? Colors.grey
                                              : Colors.black),
                                    ),
                                    onTap: finisedTasks.isEmpty
                                        ? null
                                        : () {
                                            setState(() {
                                              finisedTasks = [];
                                              Navigator.of(context).pop();
                                            });
                                          },
                                  )
                                ],
                              )
                            ],
                          ))),
                )
              ],
            ));
  }

  void buildNavigationSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              children: [
                Expanded(child: Container()),
                Material(
                  color: Colors.white,
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8.0,
                        ),
                        ListTile(
                          leading: const CircleAvatar(
                            radius: 24.0,
                            child: Text(
                              'A',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ashish Yadav',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'ashish.yd@gmail.com',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey[700]),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down)
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 10.0, bottom: 10.0),
                          child: Container(
                            height: 55.0,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2),
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(30.0))),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    'My tasks',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                        ),
                        const Divider(),
                        const ListTile(
                          leading: Icon(Icons.add),
                          title: Text('Create a new list'),
                        ),
                        const Divider(),
                        const ListTile(
                          leading: Icon(Icons.feedback),
                          title: Text('Feedback'),
                        ),
                        const ListTile(
                          title: Text('Open source licenses'),
                        ),
                        const Divider(),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 12.0, top: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text('Data protection'),
                              SizedBox(
                                width: 8.0,
                              ),
                              Icon(
                                Icons.brightness_1,
                                size: 2.0,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text('Terms of use')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
  }

  void buildNewSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              children: [
                Expanded(child: Container()),
                Material(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(6.0)),
                  child: Column(
                    children: [
                      TextField(
                        controller: controller,
                        autofocus: true,
                        style: const TextStyle(
                            fontFamily: 'Product Sans',
                            color: Colors.black,
                            fontSize: 18.0),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 20.0,
                                left: 24.0,
                                right: 24.0,
                                bottom: 12.0),
                            border: InputBorder.none,
                            hintText: 'New task'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: Icon(Icons.add_circle,
                                    color: Theme.of(context).accentColor),
                                onPressed: () {}),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  tasks.add(controller.text);
                                });
                                Navigator.of(context).pop();
                                controller.clear();
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ));
  }
}
