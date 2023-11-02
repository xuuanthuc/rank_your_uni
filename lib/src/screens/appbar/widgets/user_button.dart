import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart';

class UserQuickButton extends StatelessWidget {
  final bool isHome;

  const UserQuickButton({
    super.key,
    required this.isHome,
  });

  void _signOut(BuildContext context) {
    context.read<AuthenticationBloc>().add(OnSignOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final List<QuickMenuItem> items = [
      QuickMenuItem(
        label: text.profile,
        value: QuickMenu.profile,
      ),
      QuickMenuItem(
        label: text.settingAccount,
        value: QuickMenu.settingAccount,
      ),
      QuickMenuItem(
        label: text.yourRating,
        value: QuickMenu.yourRating,
      ),
      QuickMenuItem(
        label: text.signOut,
        value: QuickMenu.signOut,
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(0),
        ),
        border: Border.all(
          width: 2,
          color: isHome ? theme.primaryColor : Colors.white,
        ),
      ),
      height: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 0,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<QuickMenuItem>(
          isExpanded: true,
          hint: Center(
            child: Text(
              text.hey("Xuuan Thuccsd "),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: theme.primaryTextTheme.labelLarge?.copyWith(
                color: Colors.white,
                decorationColor: Colors.white,
                decorationThickness: 2,
              ),
            ),
          ),
          onChanged: (value) {
            if (value?.value == QuickMenu.signOut) {
              _signOut(context);
            }
          },
          items: items
              .map((QuickMenuItem item) => DropdownMenuItem<QuickMenuItem>(
                    value: item,
                    child: Text(
                      item.label,
                      style: theme.primaryTextTheme.labelLarge,
                    ),
                  ))
              .toList(),
          buttonStyleData: ButtonStyleData(
            width: (text.hey("Xuuan Thuccsd").length * 10),
          ),
          iconStyleData: const IconStyleData(iconSize: 0),
          dropdownStyleData: DropdownStyleData(
            width: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 1,
            offset: const Offset(-20, -20),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 50,
          ),
        ),
      ),
    );
  }
}

class QuickMenuItem {
  final String label;
  final QuickMenu value;

  const QuickMenuItem({
    required this.label,
    required this.value,
  });
}

enum QuickMenu { profile, settingAccount, yourRating, signOut }
