import 'package:flutter/material.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    Key? key,
    required this.onOpenSearch,
    required this.onChanged,
  }) : super(key: key);

  final void Function(bool) onOpenSearch;
  final void Function(String) onChanged;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: _width - 75,
          height: 40,
          child: TextFormField(
            controller: _searchController,
            focusNode: _focusNode,
            cursorColor: color(AppColor.grey),
            autofocus: true,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              color: color(AppColor.white),
              fontSize: 16,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: color(AppColor.grey),
              ),
              fillColor: color(AppColor.darkerGrey),
              filled: true,
              border: InputBorder.none,
              hintText: 'Search your interesting...',
              hintStyle: TextStyle(color: color(AppColor.grey)),
            ),
            onChanged: (String str) {
              widget.onChanged(str);
            },
          ),
        ),
        wSpace(10),
        GestureDetector(
          onTap: () {
            widget.onOpenSearch(false);
            _focusNode.unfocus(); // Unfocus when closing
          },
          child: Icon(
            Icons.close,
            size: 30,
            color: color(AppColor.white),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _focusNode.dispose();
  }
}
