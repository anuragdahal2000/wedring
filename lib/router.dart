import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/screens/Info/basic_info.dart';
import 'package:wedring/screens/Info/edu_info.dart';
import 'package:wedring/screens/Info/intrests.dart';
import 'package:wedring/screens/Info/profile_info.dart';
import 'package:wedring/screens/auth/email_reset.dart';
import 'package:wedring/screens/auth/forget_password.dart';
import 'package:wedring/screens/auth/new_password.dart';
import 'package:wedring/screens/auth/opt_verification.dart';
import 'package:wedring/screens/auth/sign_in.dart';
import 'package:wedring/screens/chat/chat_list.dart';
import 'package:wedring/screens/profile/about.dart';
import 'package:wedring/screens/profile/change_password.dart';
import 'package:wedring/screens/profile/profile_details.dart';
import 'package:wedring/screens/signup/sign_up.dart';
import 'package:wedring/screens/chat/single_chat.dart';
import 'package:wedring/screens/home/scaffold_with_bottom_nav.dart';
import 'package:wedring/screens/matches/match.dart';
import 'package:wedring/screens/onboarding/onboard.dart';
import 'package:wedring/screens/profile/profile.dart';
import 'package:wedring/screens/signup/sign_up_2.dart';
import 'package:wedring/utils/helper.dart';

import 'screens/home/home.dart';
import 'package:wedring/models/user.dart' as u;

final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static GoRouter router = GoRouter(
    navigatorKey: AppManager.navigatorKey,
    debugLogDiagnostics: true,
    initialLocation:
        FirebaseAuth.instance.currentUser != null ? '/home' : '/signin',
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
    routes: <RouteBase>[
      GoRoute(
        name: 'onboard',
        path: '/onboard',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: const OnboardScreen(),
        ),
      ),
      GoRoute(
        name: 'signin',
        path: '/signin',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: const SignIn(),
        ),
        routes: [
          GoRoute(
            name: 'forgotpassword',
            path: 'forgot-password',
            builder: (context, state) => const ForgetPassword(),
            routes: [
              GoRoute(
                  path: 'email-pw-reset',
                  name: 'email-pw-reset',
                  builder: (context, state) => const EmailPasswordReset(),
                  routes: [
                    GoRoute(
                      name: 'opt-verfication',
                      path: 'opt-verfication',
                      builder: (context, state) => const OptVerification(),
                      routes: [
                        GoRoute(
                          name: 'new-password',
                          path: 'new-password',
                          builder: (context, state) => const NewPassword(),
                        )
                      ],
                    ),
                  ]),
            ],
          ),
        ],
      ),
      GoRoute(
        name: 'signup',
        path: '/signup',
        builder: (context, state) => const SignUp(),
      ),
      GoRoute(
        name: 'signup-details',
        path: '/signup-details',
        builder: (context, state) => const SignUp2(),
        routes: [
          GoRoute(
            name: 'basic-info',
            path: 'basic-info',
            builder: (context, state) => const BasicInfo(),
            routes: [
              GoRoute(
                name: 'edu-info',
                path: 'edu-info',
                builder: (context, state) => const EduInfo(),
              )
            ],
          ),
        ],
      ),
      GoRoute(
        name: 'interests',
        path: '/interests',
        builder: (context, state) => const IntrestScreen(),
      ),
      GoRoute(
        name: 'profile-info',
        path: '/profile-info',
        builder: (context, state) => const ProfileInfo(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNav(child: child);
        },
        routes: [
          GoRoute(
            name: 'home',
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Home(),
            ),
          ),
          GoRoute(
              name: 'my-matches',
              path: '/my-matches',
              pageBuilder: (context, state) => const NoTransitionPage(
                    child: MyMatches(),
                  ),
              routes: [
                GoRoute(
                  name: 'match-user',
                  path: 'details/:userId',
                  builder: (context, state) {
                    final id = state.pathParameters['userId'] as String;
                    return ProfileDetails(
                      userId: id,
                    );
                  },
                ),
              ]),
          GoRoute(
            name: 'chat',
            path: '/chat',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ChatList(),
            ),
          ),
          GoRoute(
            name: 'profile',
            path: '/profile',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: Profile(),
              );
            },
            routes: [
              GoRoute(
                name: 'change-password',
                path: 'change-password',
                builder: (context, state) => const ChangePassword(),
              ),
              GoRoute(
                name: 'about-us',
                path: 'about-us',
                builder: (context, state) => const About(),
              ),
              GoRoute(
                name: 'profile-details',
                path: 'details/:userId',
                builder: (context, state) {
                  final id = state.pathParameters['userId'] as String;
                  return ProfileDetails(
                    userId: id,
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: 'single-chat',
        path: '/single-chat/:chatId',
        builder: (context, state) {
          final id = state.pathParameters['chatId'] as String;
          final isNewChat = state.queryParameters['new'] == 'true';
          return SingleChat(
            chatId: id,
            participant: state.extra as u.User,
            isNewChat: isNewChat,
          );
        },
      ),
    ],
  );
}

class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              FadeTransition(
            opacity: animation.drive(_curveTween),
            child: child,
          ),
          child: child,
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}
