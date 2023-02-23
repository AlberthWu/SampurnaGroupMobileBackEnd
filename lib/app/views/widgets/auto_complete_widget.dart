import 'package:asm/app/constant/color.dart';
import 'package:asm/app/models/autocomplete_model.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SGAutoCompleteWidget extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool enabled;
  final Function getData;
  final int id;
  final String name;
  final bool dataKey;
  final Function? setData;

  const SGAutoCompleteWidget(
      {Key? key,
      required this.controller,
      required this.title,
      required this.getData,
      required this.id,
      required this.name,
      this.enabled = true,
      this.dataKey = true,
      this.setData
      // this.icon,
      })
      : super(key: key);

  @override
  State<SGAutoCompleteWidget> createState() => _SGAutoCompleteWidgetState();
}

class _SGAutoCompleteWidgetState extends State<SGAutoCompleteWidget> {
  late int _id;
  late String _name;

  TextEditingController _userEditTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      _id = widget.id;
      _name = widget.name;
    });

    setState(() {});
  }

  _changeValue(value) {
    setState(() {
      _id = value.getID();
      _name = value.getName();
    });

    if (widget.dataKey) {
      widget.controller.text = value.getIDString();
    } else {
      widget.controller.text = value.getName();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<autocompleteListModel>(
      clearButtonProps: ClearButtonProps(
        isVisible: true,
        color: sgRed,
      ),
      asyncItems: (filter) => widget.getData(filter),
      compareFn: (item, selectedItem) => item.id == selectedItem.id,
      itemAsString: (autocompleteListModel u) => u.showAsString(),
      onChanged: (val) {
        widget.setData!(val);
        _changeValue(val!);
      },
      selectedItem: autocompleteListModel(id: _id, name: _name),
      popupProps: PopupPropsMultiSelection.modalBottomSheet(
        isFilterOnline: true,
        showSelectedItems: true,
        showSearchBox: true,
        itemBuilder: _customPopupItemBuilder,
        searchFieldProps: TextFieldProps(
          controller: _userEditTextController,
          decoration: InputDecoration(
            labelText: 'Search',
            prefixIcon: Icon(
              Icons.search,
              color: sgRed,
            ),
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: sgGold,
              ),
            ),
            labelStyle: TextStyle(
              color: sgBlack,
              fontWeight: FontWeight.bold,
              fontFamily: "Nexa",
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: sgRed,
              ),
              onPressed: () {
                _userEditTextController.clear();
              },
            ),
          ),
        ),
      ),
      enabled: widget.enabled,
      dropdownButtonProps: DropdownButtonProps(
        icon: Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: sgRed,
        ),
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: widget.title,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: sgGold),
          ),
          iconColor: sgRed,
        ),
      ),
    );
  }

  Widget _customPopupItemBuilder(
    BuildContext context,
    autocompleteListModel? item,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: sgRed),
              borderRadius: BorderRadius.circular(5),
              color: sgWhite,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(
          item?.name ?? '',
          style: TextStyle(
            color: sgBlack,
            fontFamily: "Nexa",
          ),
        ),
      ),
    );
  }
}
