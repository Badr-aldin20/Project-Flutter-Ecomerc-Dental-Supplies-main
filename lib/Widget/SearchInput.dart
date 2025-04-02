// Widget/SearchInput.dart
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;

  const SearchInput(
      {super.key, required this.controller, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 20, 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 30, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: (val) {
                      onChanged(val);
                    },
                    decoration: const InputDecoration(
                      hintText: "بحث...",
                      border: InputBorder.none, // لإزالة الخط السفلي
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
