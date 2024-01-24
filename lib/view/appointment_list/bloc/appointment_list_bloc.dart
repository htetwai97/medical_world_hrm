import 'package:flutter/foundation.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model_impl.dart';
import 'package:hrm_medical_world_app_two/data/vo/appointment_vo.dart';

class AppointmentListBloc extends ChangeNotifier {
  /// Bloc state
  bool isDisposed = false;

  /// Dependencies
  final HRMRepoModel _hrmRepoModel = HRMRepoModelImpl();

  /// Loading State
  bool isLoading = false;

  /// Screen states
  List<AppointmentVO>? appointmentList;
  List<AppointmentVO>? _blocAppointmentList;
  int index = 0;

  AppointmentListBloc() {
    _showLoading();
    _hrmRepoModel.getAppointments().then((response) {
      _blocAppointmentList = response.data;
      appointmentList = _blocAppointmentList
          ?.where((element) => element.status == false)
          .toList();
      _notifySafely();
      _hideLoading();
    }).onError((error, stackTrace) {
      debugPrint("Error==>$error\nStack==>$stackTrace");
      _hideLoading();
    });
  }

  void onChooseTap(int index) {
    this.index = index;
    _notifySafely();
    if (index == 0) {
      appointmentList = _blocAppointmentList
          ?.where((element) => element.status == false)
          .toList();
      _notifySafely();
    } else {
      appointmentList = _blocAppointmentList
          ?.where((element) => element.status == true)
          .toList();
      _notifySafely();
    }
  }

  /// loading situations
  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
