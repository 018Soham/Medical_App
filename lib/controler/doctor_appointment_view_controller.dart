import 'package:get/get.dart';
import 'doctor_appoinments_controller.dart';

class DoctorAppointmentViewController extends GetxController {
  var appointments = <Map<String, dynamic>>[].obs;
  final String doctorId;
  final DoctorAppointmentController _appointmentController = DoctorAppointmentController();

  DoctorAppointmentViewController(this.doctorId);

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
  }

  void fetchAppointments() {
    _appointmentController.getAppointments(doctorId).listen((appointmentList) {
      appointments.value = appointmentList;
    });
  }
}
