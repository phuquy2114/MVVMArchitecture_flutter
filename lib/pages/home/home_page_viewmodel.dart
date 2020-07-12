import 'package:flutter/material.dart';
import 'package:mvvmarchitecture_flutter/services/api_service.dart';
import 'package:mvvmarchitecture_flutter/services/locator_getit.dart';
import 'package:mvvmarchitecture_flutter/services/response/user_response.dart';

class HomePageViewModel extends ChangeNotifier {
  final _api = locator<Api>();
  UserResponse userResponse;
  VoidCallback onSuccess;
  VoidCallback onLoading;
  Function(String) onError;
  String id;

  HomePageViewModel(String id) {
    this.id = id;
  }

  void initialise(
      {VoidCallback onLoading,
      Function(String) onError,
      VoidCallback onSuccess}) {
    _api.client.getUsers(id).then((value) {
      this.onSuccess = onSuccess;
      userResponse = value;
      this.onError = onError;
      notifyListeners();
    }).catchError((error) {
      print(error);
    });
  }
}
