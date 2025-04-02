import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:flutter/material.dart';

class SearchHistory extends StatelessWidget {
  final String txt;
  final void Function() Remove;
  final void Function() Search;

  const SearchHistory(
      {super.key,
      required this.txt,
      required this.Remove,
      required this.Search});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: [
          const Icon(
            Icons.history,
            color: ColorsApp.gray,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: InkWell(
                onTap: Search,
                child: Text(
                  txt,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: ColorsApp.gray),
                )),
          ),
          const Text(
            "مسح",
            style: TextStyle(fontSize: 12, color: ColorsApp.grayWithOpcity),
          ),
          InkWell(
            onTap: Remove,
            child: const Icon(
              Icons.close,
              color: ColorsApp.grayWithOpcity,
            ),
          ),
        ],
      ),
    );
  }
}
