import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class FaceloScaffold extends StatefulWidget {
  final Widget child;

  const FaceloScaffold(this.child);

  @override
  State<FaceloScaffold> createState() => _FaceloScaffoldState();
}

class _FaceloScaffoldState extends State<FaceloScaffold> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _globalKey,
          body: Stack(
            children: [
              widget.child,
              IconButton(
                  onPressed: () {
                    _globalKey.currentState!.openDrawer();
                  },
                  color: Colors.black,
                  icon: const Icon(Icons.menu)),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
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
          )
      ),
    );
  }
}
