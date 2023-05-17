import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_mitra/screens/main_tabs/favourites.dart';
import 'package:track_mitra/screens/main_tabs/home.dart';
import 'package:track_mitra/screens/main_tabs/settings.dart';

class CurvedBNB extends StatefulWidget {
  // final int p;

  // const CurvedBNB(this.p, {Key? key}) : super(key: key);
  const CurvedBNB({Key? key}) : super(key: key);

  @override
  // State<CurvedBNB> createState() => _CurvedBNBState(pageNo: p);
  State<CurvedBNB> createState() => _CurvedBNBState();
}

class _CurvedBNBState extends State<CurvedBNB> {
  int flag = 1;
  int pageNo = 1;
  final screens = const [
    Favourites(),
    HomePage(),
    Settings(),
  ];
  // _CurvedBNBState({pageNo});
  _CurvedBNBState();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: const Color(0xFF212529),
      child: SafeArea(
        top: false,
        child: ClipRRect(
          child: Scaffold(
             appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: const Color(0xFF101010),
        title: Text(
          'T R A C K     M I T R A',
          style: GoogleFonts.rubik(
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        toolbarHeight: screenHeight * 0.1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(
              screenWidth * 0.08,
            ),
          ),
        ),
      ),
            extendBody: true,
            body: screens[flag],
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              // color: Colors.grey[800]!,
              color: const Color(0xFF101010),
              buttonBackgroundColor: Colors.white,
              index: flag,
              animationDuration: const Duration(milliseconds: 300),
              items: [
                Icon(Icons.favorite,
                    color: flag == 0 ? const Color(0xff9D0208) : Colors.white),
                Icon(Icons.home,
                    color: flag == 1 ? const Color(0xFF101010) : Colors.white),
                Icon(Icons.settings,
                    color: flag == 2 ? const Color(0xFF101010) : Colors.white),
              ],
              onTap: (index) {
                setState(() {
                  flag = index;

                  // pageNo = index;
                  // (index == 1)
                  //     ? Navigator.pushNamed(context, '/main')
                  //     : Navigator.pushNamed(context, '/song');
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
