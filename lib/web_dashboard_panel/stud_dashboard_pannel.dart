import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topics_example/web_dashboard_panel/stud_dashboard_controller.dart';
import 'package:topics_example/web_dashboard_panel/student_dashboard_screen.dart';
import 'package:topics_example/web_dashboard_panel/tiles.dart';

class StudentDashboardPanel extends StatelessWidget {
  final drawerKey;
  //final StudentController studentController;

  const StudentDashboardPanel({
    Key? key,
    this.drawerKey,
  }) : super(key: key);

  /// update __icon__ and __text__ color when button is pressed in
  /// dashboard panel
  ///
  /// default color white
  Color _updateColor(Rx<StudentDashBoardPanelScreens> currentScreen,
      StudentDashBoardPanelScreens studentDashBoardPanelScreens, bool hover,
      {required BuildContext context}) {
    if (currentScreen.value == studentDashBoardPanelScreens || hover == true) {
      return Colors.white;
    }
    return Colors.blue;
  }

  final double iconHeight = 22;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: Get.height,
      color: Colors.white,
      child: GetX<StudentDashboardController>(
        init: StudentDashboardController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),

              /// 0 Student Details
              MouseRegion(
                onEnter: (e) {
                  controller.updateHover(true);
                },
                onExit: (e) {
                  controller.updateHover(false);
                },
                child: Container(
                  width: 180,
                  height: 45,
                  margin: const EdgeInsets.only(right: 20, bottom: 5),
                  decoration: BoxDecoration(
                    color: controller.currentScreen.value ==
                            StudentDashBoardPanelScreens.studentDetails
                        ? Colors.blue.withOpacity(0.9)
                        : controller.hover.value == true
                            ? Colors.blue.withAlpha(100)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: CustomTile(
                    textColor: _updateColor(
                        controller.currentScreen,
                        StudentDashBoardPanelScreens.studentDetails,
                        controller.hover.value,
                        context: context),
                    titleMessage: "Student Details",
                    onTap: () {
                      controller.currentScreen.value =
                          StudentDashBoardPanelScreens.studentDetails;
                      //inquiryController.updateOpenInquiry(false);
                      drawerKey.currentState!.closeDrawer();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
