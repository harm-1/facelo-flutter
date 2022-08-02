import 'package:facelo/pages/login.dart';
import 'package:facelo/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

import 'facelo_scaffold.dart';
import 'pages/image_overview.dart';
import 'pages/image_view.dart';
import 'pages/trial_overview.dart';
import 'pages/vote.dart';

// void main() {
//   runApp(
//     VRouter(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(scaffoldBackgroundColor: Colors.grey),
//       routes: [
//         VWidget(path: '/login', widget: const LoginPage()),
//         VWidget(path: '/register', widget: const RegisterForm()),
//         VGuard(
//             beforeEnter: (vRedirector) async =>
//                 isLoggedIn ? null : vRedirector.to('/login'),
//             stackedRoutes: [
//               VNester(
//                 path: '/',
//                 widgetBuilder: (child) => FaceloScaffold(child),
//                 nestedRoutes: [
//                   VWidget(path: null, widget: TrialOverview()),
//                   VWidget(
//                       path: 'images',
//                       widget: const ImageOverview(),
//                       stackedRoutes: [
//                         VWidget(path: 'image', widget: ImageView())
//                       ]),
//                   VWidget(path: 'vote', widget: const Vote()),
//                   VWidget(path: 'overview', widget: TrialOverview()),
//                 ],
//               ),
//             ]),
//       ],
//     ),
//   );
// }

void main() {
  runApp(const FaceloApp());
}

class FaceloApp extends StatefulWidget {
  const FaceloApp({Key? key}) : super(key: key);

  @override
  _FaceloAppState createState() => _FaceloAppState();
}

class _FaceloAppState extends State<FaceloApp> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return VRouter(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey),
      routes: [
        VWidget(path: '/login', widget: const LoginPage()),
        VWidget(path: '/register', widget: const RegisterForm()),
        VGuard(
            beforeEnter: (vRedirector) async =>
                isLoggedIn ? null : vRedirector.to('/login'),
            stackedRoutes: [
              VNester(
                path: '/',
                widgetBuilder: (child) => FaceloScaffold(child),
                nestedRoutes: [
                  VWidget(path: null, widget: TrialOverview()),
                  VWidget(
                      path: 'images',
                      widget: const ImageOverview(),
                      stackedRoutes: [
                        VWidget(path: 'image', widget: ImageView())
                      ]),
                  VWidget(path: 'vote', widget: const Vote()),
                  VWidget(path: 'overview', widget: TrialOverview()),
                ],
              ),
            ]),
      ],
    );
  }
}
