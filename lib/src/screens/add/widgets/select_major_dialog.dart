import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/models/response/major.dart';
import '../../../../global/style/styles.dart';
import '../../../../global/utilities/extensions.dart';
import '../../widgets/primary_dialog.dart';

class SelectMajorsDialog extends StatefulWidget {
  final List<Major> majors;

  const SelectMajorsDialog({super.key, required this.majors});

  @override
  State<SelectMajorsDialog> createState() => _SelectProvinceDialogState();
}

class _SelectProvinceDialogState extends State<SelectMajorsDialog> {
  final TextEditingController _editingController = TextEditingController();
  final List<Major> _majors = [];

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _majors.addAll(widget.majors);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return PrimaryDialog(
      hasScrollBody: false,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AutoSizeText(
                  text.major,
                  style: theme.primaryTextTheme.labelLarge,
                  minFontSize: 12,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _editingController,
            onChanged: (value) {
              setState(() {
                _majors.clear();
                for (final major in widget.majors) {
                  if ((removeDiacritics(major.name?.toLowerCase() ?? ''))
                      .contains(removeDiacritics(value.trim().toLowerCase()))) {
                    _majors.add(major);
                  }
                }
              });
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.grey,
                ),
              ),
              hintText: text.search,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.grey,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              hoverColor: Colors.transparent,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Divider(
              color: AppColors.grey,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TextButton(
                  onPressed: () {
                    context.pop(_majors[index]);
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    minimumSize: MaterialStateProperty.all(Size.zero),
                    overlayColor: MaterialStateProperty.all(AppColors.level4),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: SvgPicture.asset(AppImages.iLocation),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          _majors[index].name ?? '',
                          style: theme.primaryTextTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _majors.length,
            ),
          ),
        ],
      ),
    );
  }
}
