import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topics_example/web_dashboard_panel/stud_dashboard_controller.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({Key? key}) : super(key: key);

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StudentDashboardController studentDashboardController =
      Get.put(StudentDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.redAccent.shade100,
      // drawer: Responsive.isMobile(context)
      //     ? DashBoardPanel(
      //   drawerKey: _scaffoldKey,
      //   studentController: studentController,
      //   inquiryController: inquiryController,
      //   feesController: feesController,
      // )
      //     : const SizedBox(),
      body: Row(
        children: [
          // Obx(
          //   () {
          //     return Expanded(
          //       child: studentDashboardController.currentScreen.value ==
          //               StudentDashBoardPanelScreens.studentDetails
          //           ?  StudentDashboardController()///filename
          //           :  czustom///filename
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}
