import 'package:proyecto_dam/src/pages/login_page.dart';
import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';

import 'package:proyecto_dam/src/constants/constant.dart';
import 'package:proyecto_dam/src/widgets/dots_indicator.dart';
import 'package:proyecto_dam/src/widgets/widgets.dart';

import '../constants/texts.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int currentIndexPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PageView(
              allowImplicitScrolling: true,
              // physics: AlwaysScrollableScrollPhysics(),
              children: const <Widget>[
                _WalkThrough(
                  textTitle: welcomeStartTitle1,
                  textContent:
                      welcomeStartBody1,
                  bgImg: bgWalk10,
                  walkImg: welcome,
                  ancho: 0.6,
                ),
                _WalkThrough(
                  textTitle: welcomeStartTitle2,
                  textContent:
                     welcomeStartBody2,
                  bgImg: bgWalk20,
                  walkImg: consumo,
                  ancho: 0.85,
                ),
                _WalkThrough(
                  textTitle: welcomeStartTitle3,
                  textContent:
                     welcomeStartBody3,
                  bgImg: bgWalk30,
                  walkImg: invoices,
                  ancho: 0.8,
                ),
                _WalkThrough(
                  textTitle: welcomeStartTitle4,
                  textContent: welcomeStartBody4,
                  walkImg: grupo,
                  ancho: 0.7,
                ),
              ],
              onPageChanged: (value) {
                setState(() => currentIndexPage = value);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: DotsIndicator(
                  dotsCount: 4,
                  position: currentIndexPage,
                  decorator: const DotsDecorator(
                    color: greyLetterSecundary,
                    activeColor: redLogo,
                    activeSize: Size.square(12.0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _WalkThrough extends StatelessWidget {
  final String? textTitle;
  final String? textContent;
  final String? bgImg;
  final String? walkImg;
  final double? ancho;

  const _WalkThrough({
    Key? key,
    this.textTitle,
    this.textContent,
    this.bgImg,
    this.walkImg,
    this.ancho,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        SizedBox(
          width: screen.width,
          height: screen.height,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: screen.height * 0.05),
                height: screen.height * 0.5,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    bgImg != null
                        ? Image.asset(
                            bgImg!,
                            width: screen.width,
                            height: screen.height * 0.5,
                            fit: BoxFit.fill,
                          )
                        : Container(),
                    walkImg != null
                        ? Image.asset(
                            walkImg!,
                            fit: BoxFit.fitWidth,
                            width: screen.width * ancho!,
                            // height: screen.height * 0.4,
                            //   ):
                            // SvgPicture.asset(
                            //     walkImg!,
                            //     width: screen.width,
                            //     height: screen.height * 0.4,
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(height: screen.height * 0.08),
              text(
                textTitle,
                color: greyLetter,
                size: 20,
                maxLine: 2,
                centered: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 28.0, right: 28.0),
                child: text(
                  textContent,
                  size: 16,
                  maxLine: 10,
                  centered: true,
                ),
              )
            ],
          ),
        ),
        bgImg == null
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 100,
                  ),
                  alignment: Alignment.center,
                  height: screen.width / 7,
                  child: MaterialButton(
                    padding: const EdgeInsets.all(10),
                    child: text(
                      'INICIA SESIÓN',
                      color: redLogo,
                      size: 20,
                      centered: true,
                    ),
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const LoginPage();
                        },
                        transitionDuration: const Duration(milliseconds: 400),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final curvedAnimation = CurvedAnimation(
                              parent: animation, curve: Curves.easeInOut);
                          return SlideTransition(
                            child: child,
                            position: Tween<Offset>(
                                    begin: const Offset(0, 1), end: Offset.zero)
                                .animate(curvedAnimation),
                          );
                        },
                      ),
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () =>
                  //       Navigator.pushReplacementNamed(context, 'login'),
                  //   child: text(
                  //     iniciaSesion,
                  //     color: blueLetter,
                  //     size: 18,
                  //     centered: true,
                  //   ),
                  // ),
                  // decoration:
                  //     boxDecoration(bgColor: t5ColorPrimary, radius: 8),
                ),
              )
            : Container()
      ],
    );
  }
}
