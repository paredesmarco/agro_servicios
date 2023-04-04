import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

typedef OnChangeCallback = void Function(dynamic valor);
typedef OnSaveCallback = void Function(dynamic valor);
typedef ValidatorCallback = String? Function(dynamic valor);

class ComboBusqueda extends StatelessWidget {
  final List<String> lista;
  final String? selectedItem;
  final OnChangeCallback onChange;
  final OnSaveCallback? onSave;
  final ValidatorCallback? validator;
  final String label;
  final String? errorText;
  final bool enabled;

  const ComboBusqueda(
      {Key? key,
      required this.label,
      required this.lista,
      this.errorText,
      this.selectedItem,
      required this.onChange,
      this.onSave,
      this.validator,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 8),
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[500])),
        DropdownSearch<String>(
          enabled: enabled,
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: const TextStyle(color: Colors.red),
            dropdownSearchDecoration: _buildDecoracionComboBuscar(),
          ),
          dropdownBuilder: _customDropDownExample,
          popupProps: PopupProps.dialog(
            constraints: const BoxConstraints(
              minWidth: 500,
              maxWidth: 500,
              maxHeight: 500,
            ),
            searchDelay: const Duration(milliseconds: 0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Buscar...',
                    style: TextStyle(color: Colores.TituloFormulario),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colores.TituloFormulario,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            showSelectedItems: true,
            showSearchBox: true,
            searchFieldProps: _buildDecoracionInputBuscar(),
            emptyBuilder: (BuildContext context, String? msg) => const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Sin coincidencias',
                  style: TextStyle(color: Color(0xFF75808f)),
                ),
              ),
            ),
            dialogProps: const DialogProps(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            itemBuilder: (context, item, isSelected) => ListTile(
              dense: true,
              title: Text(
                item,
                style: TextStyle(
                  color: isSelected == true
                      ? Colors.green
                      : const Color(0xFF75808f),
                ),
              ),
            ),
          ),
          dropdownButtonProps: const DropdownButtonProps(
            icon: Icon(Icons.keyboard_arrow_down, color: Color(0xFF75808f)),
          ),
          items: lista,
          selectedItem: selectedItem,
          validator: validator,
          onChanged: (valor) {
            onChange(valor);
          },
          onSaved: (valor) {
            onSave!(valor);
          },
        ),
      ],
    );
  }

  _buildDecoracionComboBuscar() {
    return InputDecoration(
      hintText: '--',
      errorText: errorText,
      fillColor: Colors.white,
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFDFDFDF)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      contentPadding: const EdgeInsets.all(10),
    );
  }

  _buildDecoracionInputBuscar() {
    return const TextFieldProps(
      autofocus: true,
      style: TextStyle(color: Color(0xFF75808f)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        isDense: true,
        contentPadding: EdgeInsets.only(top: 15, left: 9, right: 9),
      ),
    );
  }

  Widget _customDropDownExample(BuildContext context, item) {
    if (item == null) {
      return const Text(
        '--',
        style: TextStyle(color: Color(0xFF75808f)),
      );
    }

    return Text(
      item,
      style: const TextStyle(color: Color(0xFF75808f)),
    );
  }
}

class ComboBloqueado extends StatelessWidget {
  final String label;
  final double? height;

  const ComboBloqueado({Key? key, required this.label, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 8),
        Text(
          label,
          style: TextStyle(color: Colors.grey[500], fontSize: 13),
        ),
        Container(
          height: height ?? 49,
          decoration: BoxDecoration(
              border: Border.all(
                  color: const Color(0xFF75808f).withOpacity(0.4), width: 0.5),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Container(
                width: 9,
              ),
              const Text(
                '--',
                style: TextStyle(color: Color(0xFFc1c5ca)),
              ),
              Expanded(child: Container()),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFFc1c5ca),
              ),
              Container(
                width: 9,
              )
            ],
          ),
        )
      ],
    );
  }
}
