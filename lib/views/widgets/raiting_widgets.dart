import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RaitingWidget extends StatelessWidget {
  final String image;
  const RaitingWidget({
    super.key,
    required this.image,
  });

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
                ? const Padding(
                    padding: EdgeInsets.only(right: 8),
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
