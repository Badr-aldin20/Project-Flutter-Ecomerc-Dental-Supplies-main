import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:flutter/material.dart';

class CardCart extends StatelessWidget {
  final String name;
  final String modeType;
  final String price_buy;
  final String img;
  final String quantity;
  final void Function() Delete;
  final void Function() increment;
  final void Function() decrement;

  const CardCart(
      {super.key,
      required this.name,
      required this.modeType,
      required this.price_buy,
      required this.img,
      required this.quantity,
      required this.Delete,
      required this.increment,
      required this.decrement});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(img),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: double.infinity,
                          child: Text(
                            name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w900),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          width: double.infinity,
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            modeType,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                price_buy,
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              ),
                              IconButton(
                                  onPressed: Delete,
                                  icon: const Icon(
                                    Icons.delete_outline_outlined,
                                    size: 35,
                                    color: Colors.redAccent,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: increment,
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorsApp.gray, width: 2)),
                        child: const Icon(
                          Icons.add,
                          size: 30,
                        )),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 40,
                      width: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorsApp.gray, width: 2)),
                      child: Text(
                        quantity,
                        style: const TextStyle(fontSize: 25),
                      )),
                  InkWell(
                    onTap: decrement,
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorsApp.gray, width: 2)),
                        child: const Icon(
                          Icons.remove,
                          size: 30,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          endIndent: 15,
          indent: 15,
          thickness: 2,
          height: 20,
        )
      ],
    );
  }
}
