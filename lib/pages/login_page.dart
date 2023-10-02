import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/constants/app_constants.dart';
import 'package:flutter_chat_demo/constants/color_constants.dart';
import 'package:flutter_chat_demo/providers/auth_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:page_animation_transition/page_animation_interface.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: "Sign in fail");
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: "Sign in canceled");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign in success");
        break;
      default:
        break;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          AppConstants.loginTitle,
          style: TextStyle(color: ColorConstants.primaryColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset('images/log.png'),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async {
                        authProvider.handleSignIn().then((isSuccess) {
                          if (isSuccess) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                        }).catchError((error, stackTrace) {
                          Fluttertoast.showToast(msg: error.toString());
                          authProvider.handleException();
                        });
                      },
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        overlayColor: MaterialStateProperty.all(Colors.red),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        splashFactory: NoSplash.splashFactory,
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.fromLTRB(30, 15, 30, 15),
                        ),
                      ),
                    ),
                  ),
                  // Loading
                  Positioned(
                    child: authProvider.status == Status.authenticating
                        ? LoadingView()
                        : SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Chat apps have revolutionized the way people communicate in todays digital age. They provide a convenient and instant means of connecting with others, whether they are friends, family members, colleagues, or even strangers from around the world. These apps offer a wide range of features and functionalities, making them versatile tools for communication',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// body: Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextButton(
//             onPressed: () async {
//               authProvider.handleSignIn().then((isSuccess) {
//                 if (isSuccess) {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => HomePage(),
//                     ),
//                   );
//                 }
//               }).catchError((error, stackTrace) {
//                 Fluttertoast.showToast(msg: error.toString());
//                 authProvider.handleException();
//               });
//             },
//             child: Text(
//               'Sign in with Google',
//               style: TextStyle(fontSize: 16, color: Colors.white),
//             ),
//             style: ButtonStyle(
//               shape: MaterialStateProperty.all(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               overlayColor: MaterialStateProperty.all(Colors.red),
//               backgroundColor: MaterialStateProperty.all(Colors.black),
//               splashFactory: NoSplash.splashFactory,
//               padding: MaterialStateProperty.all<EdgeInsets>(
//                 EdgeInsets.fromLTRB(30, 15, 30, 15),
//               ),
//             ),
//           ),
//         ),
//         // Loading
//         Positioned(
//           child: authProvider.status == Status.authenticating
//               ? LoadingView()
//               : SizedBox.shrink(),
//         ),
//       ],
//     ),
//   ],
// ),
