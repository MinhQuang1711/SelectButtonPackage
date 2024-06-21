import 'package:flutter/material.dart';
import 'package:select_button_package/model/search_decoration.dart';

import '../const/input_decoration.dart';

class SearchBarSelect extends StatelessWidget {
  const SearchBarSelect({super.key, this.searchDecoration, this.onChanged,});
  final Function(String)? onChanged;
  final SearchDecoration? searchDecoration;

  @override
  Widget build(BuildContext context) {

    void onTapOutSide(){
      if(!FocusScope.of(context).hasPrimaryFocus){
          FocusScope.of(context).unfocus();
      }
    }
    return TextField(
      onChanged: onChanged,
      onTapOutside:(val)=> onTapOutSide(),
      decoration: searchInputDecoration(decoration: searchDecoration),
    );
  }
}