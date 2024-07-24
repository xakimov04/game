import 'package:flutter/material.dart';
import 'package:game/controller/questions_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RaitingWidget extends StatelessWidget {
  final String image;
  RaitingWidget({
    super.key,
    required this.image,
  });

  final controller = Get.find<QuestionsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: 118,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff3E87FF),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment:
              image == "star" ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            image == "olmos"
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Obx(
                      () {
                        return Text(
                          controller.olmos.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ))
                : const Text(""),
            Image.asset("assets/icons/$image.png"),
            image == "star"
                ? const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "0",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const Text(""),
          ],
        ),
      ),
    );
  }
}
