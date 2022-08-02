import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class FaceloScaffold extends StatefulWidget {
  final Widget child;

  const FaceloScaffold(this.child);

  @override
  _FaceloScaffoldState createState() => _FaceloScaffoldState();
}

class _FaceloScaffoldState extends State<FaceloScaffold> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _globalKey,
          body: widget.child,
          appBar: AppBar(
            title: const Text('hello world'),
            backgroundColor: Colors.black54,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                  ),
                  child: Text('draw Header'),
                ),
                ListTile(
                  title: const Text('Vote'),
                  onTap: () {
                    context.vRouter.to('/vote');
                    _globalKey.currentState!.openEndDrawer();
                  },
                ),
                ListTile(
                  title: const Text('overview'),
                  onTap: () {
                    context.vRouter.to('/overview');
                    _globalKey.currentState!.openEndDrawer();
                  },
                ),
                ListTile(
                  title: const Text('images'),
                  onTap: () {
                    context.vRouter.to('/images');
                    _globalKey.currentState!.openEndDrawer();
                  },
                ),
              ],
            ),
          )),
    );
  }
}
