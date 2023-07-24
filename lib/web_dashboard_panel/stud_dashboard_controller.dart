// ignore_for_file: library_prefixes
import 'package:get/get.dart';
import 'package:topics_example/web_dashboard_panel/student_dashboard_screen.dart';

class StudentDashboardController extends GetxController {
  Rx<StudentDashBoardPanelScreens> currentScreen =
      StudentDashBoardPanelScreens.studentDetails.obs;

  var hover = false.obs;
  var hover1 = false.obs;
  var hover2 = false.obs;

  updateHover(bool val) {
    hover.value = val;
    update();
  }

  updateHover1(bool val) {
    hover1.value = val;
    update();
  }

  updateHover2(bool val) {
    hover2.value = val;
    update();
  }
}
