import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sunflower_flutter/view/viewmodel/root_viewmodel.dart';


abstract class RootWidget<T extends RootViewModel> extends StatelessWidget {
  final T _model;

  get model => _model;

  const RootWidget(this._model, {super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<T>.reactive(
      disposeViewModel: false,
      // IMPORTANTE no eliminar los viewmodels para su reutilizacion
      builder: (ctx, model, child) {
        return widget(model, context);
      },
      viewModelBuilder: () => _model,
      onViewModelReady: (model) => model.initialize(),
    );
  }

  Widget widget(T model, BuildContext context);

  Widget withProgress({required Widget body, required T model}) {
    return Stack(
      children: [
        body,
        model.loading
            ? const Center(child: CircularProgressIndicator())
            : Container(),
      ],
    );
  }
}
