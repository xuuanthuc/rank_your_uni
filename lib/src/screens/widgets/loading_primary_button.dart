import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'primary_button.dart';

class LoadingPrimaryButton<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  final String label;
  final Function onTap;
  final double? buttonHeight;
  final double? buttonWidth;
  final Color? Function(S)? updateColor;
  final bool Function(S) updateLoading;

  const LoadingPrimaryButton({
    super.key,
    required this.onTap,
    required this.label,
    required this.updateLoading,
    this.buttonHeight,
    this.buttonWidth,
    this.updateColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        return SizedBox(
          width: buttonWidth,
          child: PrimaryButton(
            onTap: updateLoading(state) ? () {} : () => onTap(),
            title: label,
            height: buttonHeight ?? 46,
            backgroundColor: updateColor == null ? null : updateColor!(state),
            borderColor: updateColor == null ? null : updateColor!(state),
            child: updateLoading(state)
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : null,
          ),
        );
      },
    );
  }
}
