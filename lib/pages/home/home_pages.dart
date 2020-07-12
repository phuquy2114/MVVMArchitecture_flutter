import 'package:flutter/material.dart';
import 'package:mvvmarchitecture_flutter/base/base_viewmodel_provider.dart';
import 'package:mvvmarchitecture_flutter/model/user_model.dart';
import 'package:mvvmarchitecture_flutter/pages/home/home_page_viewmodel.dart';
import 'package:mvvmarchitecture_flutter/uitls/helpers.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<User> litems = [];

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomePageViewModel>.withConsumer(
        viewModelBuilder: () => HomePageViewModel("2"),
        onModelReady: (model) => model.initialise(onLoading: () {
              Helpers.onLoading(context);
            }, onSuccess: () {
              litems = model.userResponse.data;
              print("_HomePageState   --- > ${litems.toString()}");
            }),
        builder: (context, model, _) => Scaffold(
              appBar: AppBar(
                title: Text('List User'),
              ),
              body: Container(
                child: ListView.builder(
                    itemCount: litems.length,
                    itemBuilder: (BuildContext ctxt, int Index) {
                      return new Text(litems[Index].email);
                    }),
              ),
            ));
  }
}
