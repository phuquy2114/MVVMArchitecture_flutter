import 'package:flutter/material.dart';
import 'package:mvvmarchitecture_flutter/base/base_viewmodel_provider.dart';
import 'package:mvvmarchitecture_flutter/pages/home/home_page_viewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
        viewModelBuilder: () => HomePageViewModel("2"),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, _) => Scaffold(
              appBar: AppBar(
                title: Text('List User'),
              ),
              body: Container(),
            ));
  }
}
