import 'package:flutter/material.dart';

class ComboMultiSeleccion extends FormField<dynamic> {
  final Widget? title;
  final Widget hintWidget;
  final bool required;
  final String? errorText;
  final Function? change;
  final Function? open;
  final Function? close;
  final Widget? leading;
  final String okButtonLabel;
  final String cancelButtonLabel;
  final Color? fillColor;
  final InputBorder? border;
  final TextStyle dialogTextStyle;
  final ShapeBorder dialogShapeBorder;
  final Color? checkBoxCheckColor;
  final Color? checkBoxActiveColor;
  // ignore: overridden_fields, annotate_overrides
  final bool enabled;
  final String label;
  final List<ComboMultiSeleccionItem> items;
  final bool showAll;
  final List? value;

  /// Widget para combo con multiselección.
  ///
  /// Devuelve un Map {values: , all:} con los valores e indica si fueron seleecionados todos los valores
  /// con la propiedad Seleccionar todos
  ComboMultiSeleccion({
    super.key,
    FormFieldSetter<dynamic>? onSaved,
    FormFieldValidator<dynamic>? validator,
    dynamic initialValue = const [],
    AutovalidateMode autovalidate = AutovalidateMode.disabled,
    this.title,
    this.hintWidget = const Text('--'),
    this.required = false,
    this.errorText,
    this.leading,
    this.change,
    this.open,
    this.close,
    this.okButtonLabel = 'Aceptar',
    this.cancelButtonLabel = 'Cancelar',
    this.fillColor,
    this.border,
    this.enabled = true,
    this.dialogTextStyle = const TextStyle(),
    this.dialogShapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    this.checkBoxActiveColor,
    this.checkBoxCheckColor,
    required this.label,
    required this.items,
    this.showAll = false,
    this.value,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidate,
          builder: (FormFieldState<dynamic> state) {
            String valor = '--';
            bool? todos = false;

            if (state.value != null) {
              if ((state.value.runtimeType == List<dynamic>) ||
                  (state.value.runtimeType == List<String>) ||
                  (state.value.runtimeType == List<int>)) {
                if (state.value != null && state.value.length > 0) {
                  valor = '';
                  state.value.forEach((item) {
                    var existingItem = items.singleWhere(
                        ((itm) => itm.value == item),
                        orElse: () =>
                            ComboMultiSeleccionItem(label: '', value: ''));

                    valor = '$valor, ${existingItem.label}';
                    valor = _removerNprimerosCaracteres(
                        cadena: valor, cantidad: 2, caracterSeparador: ',');
                    valor = _removerNprimerosCaracteres(
                        cadena: valor, cantidad: 19, caracterSeparador: '[');
                  });
                }
              } else {
                if (state.value['values'] != null &&
                    state.value['values'].length > 0) {
                  valor = '';
                  state.value['values'].forEach((item) {
                    var existingItem = items.singleWhere(
                        ((itm) => itm.value == item),
                        orElse: () =>
                            ComboMultiSeleccionItem(label: '', value: ''));

                    valor = '$valor, ${existingItem.label}';
                    valor = _removerNprimerosCaracteres(
                        cadena: valor, cantidad: 2, caracterSeparador: ',');
                  });

                  todos = state.value['all'];
                }
              }
            }

            if (initialValue.length > 0) {
              state.didChange(state.value);
            } else if ((value != null) && (value.isEmpty)) {
              valor = '--';
              state.didChange({'values': [], 'all': false});
            } else {
              state.didChange(state.value);
            }

            return InkWell(
              onTap: !enabled
                  ? null
                  : () async {
                      List? initialSelected;
                      if ((state.value.runtimeType == List<dynamic>) ||
                          (state.value.runtimeType == List<String>) ||
                          (state.value.runtimeType == List<int>)) {
                        initialSelected = state.value;
                      } else {
                        if (state.value != null) {
                          initialSelected = state.value['values'];
                        }
                      }
                      initialSelected ??= [];

                      final listItems = <_MultiSelectDialogItem<dynamic>>[];

                      for (var item in items) {
                        listItems.add(
                            _MultiSelectDialogItem(item.value, item.label));
                      }

                      Map<String, dynamic>? respuesta = await showDialog(
                        context: state.context,
                        builder: (BuildContext context) {
                          return _MultiSelectDialog(
                            seleccionadosTodos: todos ?? false,
                            title: title ??
                                const Text(
                                  'Seleccione una o varias opciones',
                                  style: TextStyle(
                                    color: Color(0xFF69949C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                            okButtonLabel: okButtonLabel,
                            cancelButtonLabel: cancelButtonLabel,
                            items: listItems,
                            initialSelectedValues: initialSelected,
                            allItems: items,
                            labelStyle: dialogTextStyle,
                            dialogShapeBorder: dialogShapeBorder,
                            checkBoxActiveColor: checkBoxActiveColor,
                            checkBoxCheckColor: checkBoxCheckColor,
                            showAll: showAll,
                          );
                        },
                      );

                      List? selectedValues = respuesta?['values'];

                      todos = respuesta?['all'];

                      if (selectedValues != null) {
                        state.didChange(
                            {'values': selectedValues, 'all': todos});
                        state.save();
                      }
                    },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    label,
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                      filled: true,
                      errorText: errorText,
                      errorMaxLines: 2,
                      fillColor: fillColor ?? Colors.white,
                      isDense: true,
                      border: border ??
                          OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFDFDFDF)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding:
                          const EdgeInsets.only(left: 0, right: 0, top: 0),
                    ),
                    isEmpty: state.value == null || state.value == '',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(state.context)
                                                .orientation
                                                .index ==
                                            0
                                        ? MediaQuery.of(state.context)
                                                .size
                                                .width *
                                            0.7
                                        : MediaQuery.of(state.context)
                                                .size
                                                .width *
                                            0.81),
                                child: Text(
                                  valor,
                                  style:
                                      const TextStyle(color: Color(0xFF75808f)),
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xFF75808f),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );

  static String _removerNprimerosCaracteres(
      {required String cadena,
      required String caracterSeparador,
      required int cantidad}) {
    String? result = cadena;
    String ultimoCaracter;

    if ((cadena.isNotEmpty)) {
      ultimoCaracter = cadena.substring(0, 1);
      if (ultimoCaracter == caracterSeparador) {
        result = cadena.substring(cantidad, cadena.length);
      }
    }

    return result;
  }
}

class ComboMultiSeleccionItem {
  final dynamic value;
  final String label;

  /// Un ítem de un menú creado por un [ComboMultiSeleccion].
  ///
  /// El tipo `V` es el tipo de valor que la entrada representa. Todas las entradas
  /// en un menú proporcionado representan valores con tipos consistentes.
  ComboMultiSeleccionItem({required this.value, required this.label});
}

class _MultiSelectDialogItem<V> {
  const _MultiSelectDialogItem(this.value, this.label);

  final V value;
  final String? label;
}

class _MultiSelectDialog<V> extends StatefulWidget {
  final List<_MultiSelectDialogItem<V>>? items;
  final List<V>? initialSelectedValues;
  final Widget? title;
  final String? okButtonLabel;
  final String? cancelButtonLabel;
  final TextStyle labelStyle;
  final ShapeBorder? dialogShapeBorder;
  final Color? checkBoxCheckColor;
  final Color? checkBoxActiveColor;
  final List<dynamic> allItems;
  final bool seleccionadosTodos;
  final bool showAll;

  const _MultiSelectDialog({
    Key? key,
    this.items,
    this.initialSelectedValues,
    this.title,
    this.okButtonLabel,
    this.cancelButtonLabel,
    this.labelStyle = const TextStyle(),
    this.dialogShapeBorder,
    this.checkBoxActiveColor,
    this.checkBoxCheckColor,
    required this.allItems,
    required this.seleccionadosTodos,
    required this.showAll,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<_MultiSelectDialog<V>> {
  bool activo = false;
  final _selectedValues = <V>[];

  @override
  void initState() {
    activo = widget.seleccionadosTodos;
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.clear();
      _selectedValues.addAll(widget.initialSelectedValues!);
    }
  }

  void _onItemCheckedChange(V itemValue, bool? checked) {
    setState(() {
      if (checked!) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
        activo = false;
      }
    });
  }

  void _seleccionarTodos(bool? checked) {
    setState(() {
      activo = checked!;
      if (checked) {
        _selectedValues.clear();
        for (var e in widget.allItems) {
          _selectedValues.add(e.value);
        }
      } else {
        _selectedValues.clear();
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context, {'all': activo});
  }

  void _onSubmitTap() {
    Navigator.pop(context, {'values': _selectedValues, 'all': activo});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      shape: widget.dialogShapeBorder,
      contentPadding: const EdgeInsets.only(top: 12.0),
      content: Container(
        constraints: const BoxConstraints(maxHeight: 400),
        width: 340,
        child: Scrollbar(
          thumbVisibility: true,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Visibility(
                      visible: widget.showAll,
                      child: CheckboxListTile(
                        value: activo,
                        checkColor: widget.checkBoxCheckColor,
                        activeColor: widget.checkBoxActiveColor,
                        title: const Text(
                          '[Seleccionar todos]',
                          style: TextStyle(color: Color(0xFF75808f)),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (checked) {
                          _seleccionarTodos(checked);
                        },
                      ),
                    )
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return widget.items!.map(_buildItem).elementAt(index);
                  },
                  childCount: widget.items!.length,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _onCancelTap,
          child: Text(widget.cancelButtonLabel!),
        ),
        TextButton(
          onPressed: _onSubmitTap,
          child: Text(widget.okButtonLabel!),
        )
      ],
    );
  }

  Widget _buildItem(_MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      checkColor: widget.checkBoxCheckColor,
      activeColor: widget.checkBoxActiveColor,
      title: Text(
        item.label!,
        style: const TextStyle(color: Color(0xFF75808f)),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) {
        _onItemCheckedChange(item.value, checked);
      },
    );
  }
}
