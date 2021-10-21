import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/theme/own_theme_fields.dart';
import '../../util/ui_constants.dart';
import 'widgets/BottomScroller.dart';
import 'widgets/GetDepartment.dart';
import 'widgets/GetID.dart';
import 'widgets/GetInterests.dart';
import 'widgets/GetName.dart';
import 'widgets/GetPassword.dart';
import 'widgets/GetPhoto.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _totalPages = 4;
  int _currentPage = 1;
  int? _currentMailChoice;
  List<bool> interestChoices = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  int? currentDepartmentChoice;
  bool changedOnce = false;
  TextEditingController? _getNameController;
  TextEditingController? _getIDController;
  PageController? _pageController;

  void initVariables() {
    if (mounted) {
      setState(() {
        _getNameController = TextEditingController();
        _getIDController = TextEditingController();
        _pageController = PageController();
      });
    }
  }

  @override
  initState() {
    super.initState();
    initVariables();
  }

  @override
  dispose() {
    super.dispose();
    _getNameController?.dispose();
    _getIDController?.dispose();
    _pageController?.dispose();
  }

  Widget pages() {
    return PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[pageOne(), pageTwo(), pageThree(), pageFour()]);
  }

  Widget pageOne() {
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GetName(textEditingController: _getNameController),
          SizedBox(height: UIConstants.getColumnSpacing(context)),
          GetID(
              textEditingController: _getIDController,
              visible: _getNameController!.text.length != 0),
          SizedBox(height: UIConstants.getColumnSpacing(context)),
          GetDepartment(
            visible: _getIDController!.text.length == 8 &&
                _getNameController!.text.length != 0,
            currentChoice: currentDepartmentChoice,
            departments: [
              "Computer Science",
              "Electrical-Electronical Engine1ering",
              "Management",
              "Interior Architecture",
              "Mathematics",
              "Physics"
            ],
            onTap: (index) {
              setState(() {
                currentDepartmentChoice = index;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget pageTwo() {
    return Column(
      children: <Widget>[GetPhoto()],
    );
  }

  Widget pageThree() {
    return Container(
      child: GetInterests(
        interests: [
          "Art",
          "Science",
          "Sports",
          "Politics",
          "History",
          "Art",
          "Science",
          "Sports",
          "Politics",
          "History",
          "Art",
          "Science",
          "Sports",
          "Politics",
          "History",
          "Art",
          "Science",
          "Sports",
          "Politics",
          "History"
        ],
        choices: interestChoices,
        onTap: (index) {
          setState(() {
            interestChoices[index] = !interestChoices[index];
          });
        },
      ),
    );
  }

  Widget pageFour() {
    return GetPassword(
      choseMail: _currentMailChoice,
      onMailChoose: (value) {
        setState(() {
          _currentMailChoice = value;
        });
      },
    );
  }

  Widget body() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom +
                UIConstants.getSafeHeight(context) * .05),
        color: Theme.of(context).backgroundColor,
        child: pages());
  }

  Widget bottomScroller() {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom,
      left: UIConstants.getPaddingHorizontal(context) * 1.5,
      right: UIConstants.getPaddingHorizontal(context) * 1.5,
      child: BottomScroller(
          totalPages: _totalPages,
          pageNumber: _currentPage,
          onBackTap: () {
            setState(() {
              _pageController?.previousPage(
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);
              _currentPage -= 1;
            });
          },
          onNextTap: () {
            setState(() {
              if (_currentPage < _totalPages) {
                _pageController?.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                _currentPage += 1;
              }
            });
          },
          nextVisible: _currentPage != _totalPages &&
              _getIDController!.text.length == 8 &&
              _getNameController!.text.length != 0 &&
              currentDepartmentChoice != null),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      elevation: 0.5,
      title: Text("YACM",
          style: GoogleFonts.pacifico(
              fontStyle: FontStyle.italic,
              color: Theme.of(context).own().loginAppNameColor)),
      backgroundColor: Theme.of(context).backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Theme.of(context).own().generalReturnColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBar(),
          body: Stack(
            children: <Widget>[body(), bottomScroller()],
          )),
    );
  }
}
