import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/prefix_icon.dart';
import 'package:hyper_tools/extensions/bool_extension.dart';
import 'package:hyper_tools/extensions/text_editing_controller_extension.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:provider/provider.dart';

class SearchBarField extends HookWidget {
  const SearchBarField({
    required this.onValueChanged,
    super.key,
    this.hintText,
  });

  final void Function(String) onValueChanged;
  final String? hintText;

  Widget _buildClearButton(TextEditingController controller) => Builder(
        builder: (BuildContext context) => TextButton(
          onPressed: controller.clear,
          child: FaIcon(
            FontAwesomeIcons.circleXmark,
            color: Theme.of(context).hintColor,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();

    useEffect(
      controller.onValueChanged(onValueChanged),
      <Object?>[],
    );

    final String filter = context.select<HomeProvider, String>(
      (HomeProvider provider) => provider.filter,
    );

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const TextFieldIcon(FontAwesomeIcons.magnifyingGlass),
        suffixIcon: filter.isEmpty
            .branch<Widget>(ifFalse: _buildClearButton(controller)),
      ),
    );
  }
}
