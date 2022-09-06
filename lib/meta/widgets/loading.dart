import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String message;

  const Loading({
    super.key,
    this.message = "Loading",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                const SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
