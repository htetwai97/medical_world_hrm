import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model_impl.dart';
import 'package:hrm_medical_world_app_two/data/vo/appointment_vo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hrm_medical_world_app_two/data/vo/user_data_vo.dart';
import 'package:http_parser/http_parser.dart';

class AppointmentDetailBloc extends ChangeNotifier {
  /// Bloc state
  bool isDisposed = false;

  /// Dependencies
  final HRMRepoModel _hrmRepoModel = HRMRepoModelImpl();

  /// Loading State
  bool isLoading = false;
  bool inAppLoading = false;

  /// Screen states
  AppointmentVO? appointmentVO;
  TextEditingController textEditingController = TextEditingController();
  Position? positionLocated;
  UserDataVO? userDataVO;
  String? attendanceId;
  File? attachFile;
  String? fileName;

  AppointmentDetailBloc(String appointmentId) {
    _showLoading();
    _determinePosition().then((position) {
      positionLocated = position;
      _notifySafely();
      _hrmRepoModel
          .getSingleAppointment(appointmentId)
          .then((appointmentResponse) {
        appointmentVO = appointmentResponse.data;
        _notifySafely();
        _hrmRepoModel.getEmployeeData().then((response) {
          userDataVO = response.user;
          _notifySafely();
          _hideLoading();
        }).onError((error, stackTrace) {
          debugPrint("Error==>$error\nStackTrace==>$stackTrace");
          _hideLoading();
        });
      }).onError((error, stackTrace) {
        debugPrint("Error==>$error\nStackTrace==>$stackTrace");
        _hideLoading();
      });
    });
  }

  void onPickedAttachFile(File? file) {
    attachFile = file;
    fileName = file?.path.split("/").last;
    _notifySafely();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      // return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var currentLocation = await Geolocator.getCurrentPosition(
        // forceAndroidLocationManager: true,
        // desiredAccuracy: LocationAccuracy.best,
        );
    return currentLocation;
  }

  Future<void> _checkInHrm() async {
    _showInAppLoading();
    await _determinePosition().then((position) {
      positionLocated = position;
    }).onError((e, _) {
      Functions.toast(msg: "Location access error", status: false);
    });
    var date = DateTime.now().toString().substring(0, 10);
    var time = DateTime.now().toString().substring(11, 16);
    await _hrmRepoModel
        .postHrmCheckIn(
      userDataVO?.sId ?? "",
      userDataVO?.relatedDepartment?.sId ?? "",
      time,
      date,
      // positionLocated?.latitude ?? 0,
      // positionLocated?.longitude ?? 0,
      appointmentVO?.latitude ?? 0,
      appointmentVO?.longitude ?? 0,
      appointmentVO?.latitude ?? 0,
      appointmentVO?.longitude ?? 0,
    )
        .then((response) async {
      if (response.success == true) {
        attendanceId = response.data?.sId ?? "";
        await _hrmRepoModel
            .putAppointmentCheckIn(appointmentVO?.sId ?? "", time)
            .then((response) async {
          await _hrmRepoModel
              .getSingleAppointment(appointmentVO?.sId ?? "")
              .then((value) {
            appointmentVO = value.data;
            _notifySafely();
            _hideInAppLoading();
          }).onError((error, stackTrace) {
            debugPrint("Error==>$error\nStackTrace==>$stackTrace");
            _hideInAppLoading();
          });
        }).onError((error, stackTrace) {
          debugPrint("Error==>$error\nStackTrace==>$stackTrace");
          _hideInAppLoading();
        });
      } else {
        _hideInAppLoading();
        Functions.toast(
            msg:
                "သင်သည်သတ်မှတ်ထားသောနေရာသို့မရောက်သေးပါသဖြင့် check in လုပ်၍မရပါ",
            status: false);
      }
    }).onError((error, stackTrace) {
      _hideInAppLoading();
      Functions.toast(msg: "HRM Check in failed", status: false);
    });
  }

  Future<void> _checkOutHrm() async {
    _showInAppLoading();
    await _determinePosition().then((position) {
      positionLocated = position;
    }).onError((e, _) {
      Functions.toast(msg: "Location access error", status: false);
    });
    var time = DateTime.now().toString().substring(11, 16);
    await _hrmRepoModel
        .postHrmCheckOut(
      time,
      attendanceId ?? "",
      // positionLocated?.latitude ?? 0,
      // positionLocated?.longitude ?? 0,
      appointmentVO?.latitude ?? 0,
      appointmentVO?.longitude ?? 0,
      appointmentVO?.latitude ?? 0,
      appointmentVO?.longitude ?? 0,
    )
        .then((response) async {
      if (response.success == true) {
        await _hrmRepoModel
            .putAppointmentCheckOut(appointmentVO?.sId ?? "", time)
            .then((response) async {
          await _hrmRepoModel
              .getSingleAppointment(appointmentVO?.sId ?? "")
              .then((value) {
            appointmentVO = value.data;
            _notifySafely();
            _hideInAppLoading();
          }).onError((error, stackTrace) {
            debugPrint("Error==>$error\nStackTrace==>$stackTrace");
            _hideInAppLoading();
          });
        }).onError((error, stackTrace) {
          debugPrint("Error==>$error\nStackTrace==>$stackTrace");
          _hideInAppLoading();
        });
      } else {
        _hideInAppLoading();
        Functions.toast(
            msg:
                "သင်သည်သတ်မှတ်ထားသောနေရာသို့မရောက်သေးပါသဖြင့် check out လုပ်၍မရပါ",
            status: false);
      }
    }).onError((error, stackTrace) {
      Functions.toast(msg: "HRM Check Out failed", status: false);
    });
  }

  Future<void> onCheckIn() async {
    await _checkInHrm();
  }

  Future<void> onCheckOut() async {
    await _checkOutHrm();
  }

  Future<void> onTapSubmit() async {
    _showInAppLoading();
    if (appointmentVO?.isCheckIn == true &&
        appointmentVO?.isCheckOut == true &&
        textEditingController.text != "") {
      var data = FormData.fromMap({
        "report": textEditingController.text,
        "reportFile": await MultipartFile.fromFile(
          attachFile!.path,
          filename: fileName,
          contentType: MediaType('image', 'png'),
        ),
      });
      await _hrmRepoModel
          .putAppointmentReport(
              appointmentVO?.sId ?? "", textEditingController.text, data)
          .then((response) {
        return Future.value();
      }).onError((error, stackTrace) {
        debugPrint("Error==>$error\nStackTrace==>$stackTrace");
        _hideInAppLoading();
        return Future.error("error");
      });
    } else {
      _hideInAppLoading();
      Functions.toast(msg: "Actions not completed", status: false);
      return Future.error("error");
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

  void _showInAppLoading() {
    inAppLoading = true;
    _notifySafely();
  }

  void _hideInAppLoading() {
    inAppLoading = false;
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
