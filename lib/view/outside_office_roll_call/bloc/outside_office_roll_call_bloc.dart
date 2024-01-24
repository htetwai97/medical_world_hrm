import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model_impl.dart';
import 'package:hrm_medical_world_app_two/data/vo/attendance_id_vo.dart';
import 'package:hrm_medical_world_app_two/data/vo/user_data_vo.dart';

class OutsideOfficeRollCallBloc extends ChangeNotifier {
  /// Bloc state
  bool isDisposed = false;

  /// Dependencies
  final HRMRepoModel _hrmRepoModel = HRMRepoModelImpl();

  /// Loading State
  bool isLoading = false;
  bool inAppLoading = false;

  /// Screen states
  TextEditingController textEditingController = TextEditingController();
  Position? positionLocated;
  UserDataVO? userDataVO;
  String? attendanceId;
  String? clockIn;
  String? clockOut;
  File? attachFile;
  String? fileName = "No File";
  List<AttendanceIdVO>? attendanceList;

  OutsideOfficeRollCallBloc() {
    _showLoading();
    _hrmRepoModel.getEmployeeData().then((response) {
      userDataVO = response.user;
      _hrmRepoModel
          .getAlreadyAttendanceList(DateTime.now().toString().substring(0, 11))
          .then((value) {
        attendanceList = value.data;
        if (attendanceList != null && attendanceList?.length != 0) {
          attendanceId = attendanceList!.elementAt(0).sId;
          clockIn = attendanceList!.elementAt(0).clockIn;
          clockOut = attendanceList!.elementAt(0).clockOut;
          textEditingController.text =
              attendanceList!.elementAt(0).report ?? "";
          fileName =
              attendanceList!.elementAt(0).attachFile?.substring(0, 70) ?? "";
        }
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

  void onPickedAttachFile(File? file) {
    attachFile = file;
    fileName = file?.path.split("/").last;
    _notifySafely();
  }

  Future<void> onCheckIn() async {
    _showInAppLoading();
    await _determinePosition().then((position) {
      positionLocated = position;
    }).onError((e, _) {
      Functions.toast(msg: "Location access error", status: false);
    });
    var date = DateTime.now().toString().substring(0, 10);
    var time = DateTime.now().toString().substring(11, 16);
    await _hrmRepoModel
        .postHrmCheckInOutside(
            true,
            userDataVO?.sId ?? "",
            userDataVO?.relatedDepartment?.sId ?? "",
            time,
            date,
            positionLocated?.latitude ?? 0,
            positionLocated?.longitude ?? 0)
        .then((response) async {
      if (response.success == true) {
        attendanceId = response.data?.sId ?? "";
        clockIn = response.data?.clockIn ?? "";
        _notifySafely();
        _hideInAppLoading();
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

  Future<void> onCheckOut() async {
    _showInAppLoading();
    await _determinePosition().then((position) {
      positionLocated = position;
    }).onError((e, _) {
      Functions.toast(msg: "Location access error", status: false);
    });
    var time = DateTime.now().toString().substring(11, 16);
    await _hrmRepoModel
        .postHrmCheckOutOutside(
            true,
            time,
            textEditingController.text,
            attendanceId ?? "",
            positionLocated?.latitude ?? 0,
            positionLocated?.longitude ?? 0,
            attachFile,
            fileName)
        .then((response) {
      if (response.success == true) {
        clockOut = response.data?.clockOut ?? "";
        _notifySafely();
        _hideInAppLoading();
      } else {
        _hideInAppLoading();
        Functions.toast(
            msg:
                "သင်သည်သတ်မှတ်ထားသောနေရာသို့မရောက်သေးပါသဖြင့် check out လုပ်၍မရပါ",
            status: false);
      }
    }).onError((error, stackTrace) {
      _hideInAppLoading();
      Functions.toast(msg: "HRM Check out failed", status: false);
    });
  }

  Future<void> onTapSubmit() async {
    _showInAppLoading();
    if (clockIn != null && clockIn != "") {
      if (textEditingController.text.isNotEmpty || attachFile != null) {
        await _determinePosition().then((position) {
          positionLocated = position;
        }).onError((e, _) {
          Functions.toast(msg: "Location access error", status: false);
        });
        await _hrmRepoModel
            .postHrmCheckOutOutside(
          true,
          clockOut ?? "",
          textEditingController.text,
          attendanceId ?? "",
          positionLocated?.latitude ?? 0,
          positionLocated?.longitude ?? 0,
          attachFile,
          fileName,
        )
            .then((response) {
          if (response.success == true) {
            clockOut = response.data?.clockOut ?? "";
            _notifySafely();
            _hideInAppLoading();
            return Future.value();
          } else {
            _hideInAppLoading();
            Functions.toast(
                msg:
                    "သင်သည်သတ်မှတ်ထားသောနေရာသို့မရောက်သေးပါသဖြင့် check out လုပ်၍မရပါ",
                status: false);
            return Future.error("error");
          }
        }).onError((error, stackTrace) {
          _hideInAppLoading();
          Functions.toast(msg: "HRM Check out failed", status: false);
          return Future.error("error");
        });
      } else {
        _hideInAppLoading();
        Functions.toast(msg: "No report to submit", status: false);
        return Future.error("error");
      }
    } else {
      _hideInAppLoading();
      Functions.toast(msg: "Check In first", status: false);
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
