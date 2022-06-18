import 'package:flutter/material.dart';

class SuggestionsCard extends StatelessWidget {
  const SuggestionsCard({
    Key? key,
    this.child,
  }) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AnimatedContainer(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 5,
                  maxWidth: MediaQuery.of(context).size.width * 0.62),
              duration: const Duration(milliseconds: 500),
              child: Card(
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
