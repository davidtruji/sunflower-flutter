import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/root_viewmodel.dart';

abstract class RootWidget<T extends RootViewModel> extends StatelessWidget {
  final T _model;

  get model => _model;

  const RootWidget(this._model, {super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<T>.reactive(
      builder: (ctx, model, child) {
        return widget(model);
      },
      viewModelBuilder: () => _model,
      onViewModelReady: (model) => model.initialize(),
    );
  }

  Widget widget(T model);

  Widget withProgress({required Widget body, required T model}) {
    return Stack(
      children: [
        body,
        model.loading
            ? Center(child: CircularProgressIndicator())
            : Container(),
      ],
    );
  }
}