import 'package:asm/app/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SGDropDownListWidget extends StatefulWidget {
  final TextEditingController controller;
  final List<String> data;
  final String title;
  final bool enabled;
  final icon;

  const SGDropDownListWidget({
    Key? key,
    required this.controller,
    required this.data,
    required this.title,
    this.enabled = true,
    this.icon,
  }) : super(key: key);

  @override
  State<SGDropDownListWidget> createState() => _SGDropDownListWidgetState();
}

class _SGDropDownListWidgetState extends State<SGDropDownListWidget> {
  TextEditingController _userEditTextController = TextEditingController();
  String? _selectedVal;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedVal = widget.controller.text;
    });
  }

  _changeValue(value) {
    setState(() {
      _selectedVal = value as String;
    });

    widget.controller.text = value as String;
  }

  @override
  Widget build(BuildContext context) {
    return widget.icon != null
        ? DropdownSearch<String>(
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
                    color: sgGrey,
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
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _userEditTextController.clear();
                    },
                  ),
                ),
              ),
            ),
            enabled: widget.enabled,
            items: widget.data,
            onChanged: (val) => _changeValue(val),
            selectedItem: _selectedVal != null ? _selectedVal : widget.data[0],
            validator: (String? item) {
              if (item == null)
                return "Required field";
              else
                return null;
            },
            dropdownButtonProps: DropdownButtonProps(
              icon: Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: sgRed,
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: widget.title,
                prefixIcon: Icon(
                  Icons.group_add_outlined,
                  color: sgRed,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: sgGold),
                ),
                iconColor: sgRed,
              ),
            ),
          )
        : DropdownSearch<String>(
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
                    color: sgGrey,
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
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _userEditTextController.clear();
                    },
                  ),
                ),
              ),
            ),
            enabled: widget.enabled,
            items: widget.data,
            onChanged: (val) => _changeValue(val),
            selectedItem: _selectedVal != null ? _selectedVal : widget.data[0],
            validator: (String? item) {
              if (item == null)
                return "Required field";
              else
                return null;
            },
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
    String item,
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
          item,
          style: TextStyle(
            color: sgBlack,
            fontFamily: "Nexa",
          ),
        ),
      ),
    );
  }
}
