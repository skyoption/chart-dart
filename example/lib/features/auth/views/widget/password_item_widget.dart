import 'package:example/core/consts/exports.dart';

class PasswordItemWidget extends StatefulWidget {
  final String title;
  final Function(String value) onChanged;

  const PasswordItemWidget({
    super.key,
    required this.title,
    required this.onChanged,
  });

  @override
  State<PasswordItemWidget> createState() => _PasswordItemWidgetState();
}

class _PasswordItemWidgetState extends State<PasswordItemWidget> {
  String text = '';
  int level = 0;

  List<_Password> passwords = [];

  late FocusNode focusNode;

  @override
  void initState() {
    passwords = [
      _Password(index: 0, check: false),
      _Password(index: 1, check: false),
      _Password(index: 2, check: false),
      _Password(index: 3, check: false),
      _Password(index: 4, check: false),
    ];
    widget.onChanged(text);
    focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPasswordWidget(
          unActiveSize: 18.0,
          activeSize: 24.0,
          activeColor: context.colorScheme.onSurface,
          unActiveColor: context.colorScheme.onSurface,
          child: (icon, hide) {
            return MTextFiled(
              focusNode: focusNode,
              title: widget.title,
              hintText: context.tr.enterYourPassword,
              titleColor: context.colorScheme.onSurface,
              textColor: context.colorScheme.onSurface,
              hintColor: context.colorScheme.onSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: context.colorScheme.outline,
                ),
              ),
              onChanged: (value) => setPassword(value),
              textSize: FoontSize.font18,
              titleSize: FoontSize.font18,
              hintSize: FoontSize.font16,
              contentPadding: MPadding.set(horizontal: 21.0, vertical: 14.0),
              suffix: icon,
              obscureText: hide,
              keyboardType: TextInputType.visiblePassword,
            ).addPadding(bottom: 12.0);
          },
        ),
        if ((text.isNotEmpty || level <= 4) && focusNode.hasFocus)
          Row(
            children: passwords.asMap().entries.map((item) {
              return Expanded(
                child: Container(
                  margin: const MPadding.set(horizontal: 2.0),
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: level == 0 && item.key == 0
                        ? context.colorScheme.error
                        : level < item.key
                            ? context.colorScheme.surfaceVariant
                            : level >= 2 || level > item.key
                                ? context.colorScheme.success
                                : context.colorScheme.warning,
                  ),
                ),
              );
            }).toList(),
          ).addPadding(bottom: 17.0),
        if ((text.isNotEmpty || level <= 4) && focusNode.hasFocus)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MText(
                    text: "• ${context.tr.longPasswordValidation}",
                    size: FoontSize.font16,
                    weight: FontWeight.w400,
                    color: passwords[3].check
                        ? context.colorScheme.success
                        : context.colorScheme.error,
                  ).addPadding(bottom: 6.0),
                  MText(
                    text: "• ${context.tr.upperCaseValidation}",
                    size: FoontSize.font16,
                    weight: FontWeight.w400,
                    color: passwords[0].check
                        ? context.colorScheme.success
                        : context.colorScheme.error,
                  ).addPadding(bottom: 6.0),
                  MText(
                    text: "• ${context.tr.lowerCaseValidation}",
                    size: FoontSize.font16,
                    weight: FontWeight.w400,
                    color: passwords[1].check
                        ? context.colorScheme.success
                        : context.colorScheme.error,
                  ).addPadding(bottom: 6.0),
                  MText(
                    text: "• ${context.tr.symbolValidation}",
                    size: FoontSize.font16,
                    weight: FontWeight.w400,
                    color: passwords[2].check
                        ? context.colorScheme.success
                        : context.colorScheme.error,
                  ).addPadding(bottom: 6.0),
                  MText(
                    text: "• ${context.tr.includeNumbersValidation}",
                    size: FoontSize.font16,
                    weight: FontWeight.w400,
                    color: passwords[4].check ? AppColors.green : AppColors.red,
                  ).addPadding(bottom: 6.0),
                ],
              ),
              MText(
                text: level < 1
                    ? context.tr.weak
                    : level < 3
                        ? context.tr.fair
                        : level < 4
                            ? context.tr.good
                            : context.tr.strong,
                size: FoontSize.font17,
                weight: FontWeight.w400,
                color: level < 1
                    ? context.colorScheme.error
                    : level < 3
                        ? context.colorScheme.warning
                        : context.colorScheme.success,
              ),
            ],
          ),
      ],
    ).addPadding(bottom: 16.0);
  }

  bool hasUpperCase(text) {
    return RegExp(r'[A-Z]').hasMatch(text);
  }

  bool hasLowerCase(text) {
    return RegExp(r'[a-z]').hasMatch(text);
  }

  bool hasNumbers(text) {
    return RegExp(r'\d').hasMatch(text);
  }

  bool hasSymbols(text) {
    return RegExp(r'[\$&@\-()/!?]').hasMatch(text);
  }

  void setPassword(value) {
    text = value;
    final isUpperCase = hasUpperCase(value);
    final isLowerCase = hasLowerCase(value);
    final isSymbols = hasSymbols(value);
    final isNumbers = hasNumbers(value);
    final isLarge = value.length >= 8;
    passwords[0].check = isUpperCase;
    passwords[1].check = isLowerCase;
    passwords[2].check = isSymbols;
    passwords[3].check = isLarge;
    passwords[4].check = isNumbers;

    final results = [isUpperCase, isLowerCase, isSymbols, isLarge, isNumbers];
    level = results.where((e) => e).length - 1;
    setState(() {});
    widget.onChanged(value);
  }
}

class _Password {
  bool check;
  final int index;

  _Password({
    required this.index,
    required this.check,
  });
}
