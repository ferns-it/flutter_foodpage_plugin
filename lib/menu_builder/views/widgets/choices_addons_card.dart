import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/widgets/custom_rounded_textfield.dart';
import 'package:flutter_foodpage_plugin/order_online/models/dishes/choice_group.dart';

/// Shared outlined button style, same as the "Add Variation" button.
ButtonStyle _outlinedStyle(BuildContext context, Color color) {
  return OutlinedButton.styleFrom(
    textStyle: Theme.of(context)
        .textTheme
        .labelLarge, // between titleSmall and labelMedium
    foregroundColor: color,
    side: BorderSide(width: 1, color: color),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    minimumSize: const Size(0, 36), // default is 64x40, compact was 30
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    iconSize: 18,
  );
}

class ChoicesAddonsCard extends StatefulWidget {
  const ChoicesAddonsCard({
    super.key,
    this.initialGroups = const [],
    this.onChanged,
  });

  final List<ChoiceGroup> initialGroups;
  final ValueChanged<List<ChoiceGroup>>? onChanged;

  @override
  State<ChoicesAddonsCard> createState() => _ChoicesAddonsCardState();
}

class _ChoicesAddonsCardState extends State<ChoicesAddonsCard> {
  late final List<ChoiceGroup> _groups = List.of(widget.initialGroups);
  bool _addingGroup = false;

  void _notify() {
    widget.onChanged?.call(_groups);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Choices & Addons", style: textTheme.titleMedium),
            Divider(color: Colors.grey.shade300, height: 40.0),
            for (final group in _groups) ...[
              _GroupCard(
                key: ObjectKey(group),
                group: group,
                onChanged: _notify,
                onDelete: () {
                  _groups.remove(group);
                  _notify();
                },
              ),
              const SizedBox(height: 12),
            ],
            if (_addingGroup)
              _AddGroupForm(
                onCancel: () => setState(() => _addingGroup = false),
                onSave: (name) {
                  _groups.add(ChoiceGroup(name: name));
                  _addingGroup = false;
                  _notify();
                },
              )
            else
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: () => setState(() => _addingGroup = true),
                  icon: const Icon(FluentIcons.add_24_filled),
                  label: const Text("Add New Group"),
                  style: _outlinedStyle(context, MenuBuilderColors.kBlue),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared pieces
// ---------------------------------------------------------------------------

class _FormButtons extends StatelessWidget {
  const _FormButtons({required this.onCancel, required this.onSave});
  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton.icon(
          onPressed: onCancel,
          icon: const Icon(Icons.cancel_outlined),
          label: const Text("Cancel"),
          style: _outlinedStyle(context, MenuBuilderColors.kMaterialRed),
        ),
        OutlinedButton.icon(
          onPressed: onSave,
          icon: const Icon(FluentIcons.save_24_filled),
          label: const Text("Save"),
          style: _outlinedStyle(context, MenuBuilderColors.kBlue),
        ),
      ],
    );
  }
}

class _GroupFrame extends StatelessWidget {
  const _GroupFrame({required this.header, required this.child});
  final Widget header;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blueGrey.shade50,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: header,
            ),
            Padding(padding: const EdgeInsets.all(10), child: child),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Add group form
// ---------------------------------------------------------------------------

class _AddGroupForm extends StatefulWidget {
  const _AddGroupForm({required this.onCancel, required this.onSave});
  final VoidCallback onCancel;
  final ValueChanged<String> onSave;

  @override
  State<_AddGroupForm> createState() => _AddGroupFormState();
}

class _AddGroupFormState extends State<_AddGroupForm> {
  final _name = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _save() {
    final value = _name.text.trim();
    if (value.isEmpty) {
      setState(() => _error = "Enter a group name");
      return;
    }
    widget.onSave(value);
  }

  @override
  Widget build(BuildContext context) {
    return _GroupFrame(
      header: const Center(
        child: Text("Add New Group",
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      child: Column(
        children: [
          CustomRoundedTextField(
            borderRadius: BorderRadius.circular(8),
            textEditingController: _name,
            hintText: "Group Name",
            isDense: true,
            onFieldSubmitted: (value) {
              (_) => _save();
            },
          ),
          const SizedBox(height: 8),
          _FormButtons(onCancel: widget.onCancel, onSave: _save),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Group card with choices
// ---------------------------------------------------------------------------

class _GroupCard extends StatefulWidget {
  const _GroupCard({
    super.key,
    required this.group,
    required this.onChanged,
    required this.onDelete,
  });

  final ChoiceGroup group;
  final VoidCallback onChanged;
  final VoidCallback onDelete;

  @override
  State<_GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<_GroupCard> {
  bool _addingChoice = false;

  @override
  Widget build(BuildContext context) {
    final group = widget.group;

    return _GroupFrame(
      header: Row(
        children: [
          const SizedBox(width: 24),
          Expanded(
            child: Text(
              group.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          InkWell(
            onTap: widget.onDelete,
            child: const Icon(Icons.close,
                size: 18, color: MenuBuilderColors.kMaterialRed),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (group.items.isNotEmpty)
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              itemCount: group.items.length,
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) newIndex -= 1;
                final item = group.items.removeAt(oldIndex);
                group.items.insert(newIndex, item);
                widget.onChanged();
              },
              itemBuilder: (context, index) {
                final item = group.items[index];
                return ListTile(
                  key: ObjectKey(item),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: ReorderableDragStartListener(
                    index: index,
                    child: const Icon(Icons.open_with, size: 16),
                  ),
                  title: Text("${item.name} - ${item.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18),
                    color: Colors.pink,
                    onPressed: () {
                      group.items.removeAt(index);
                      widget.onChanged();
                    },
                  ),
                );
              },
            ),
          if (group.items.isNotEmpty) const Divider(height: 16),
          if (_addingChoice)
            _AddChoiceForm(
              onCancel: () => setState(() => _addingChoice = false),
              onSave: (item) {
                group.items.add(item);
                setState(() => _addingChoice = false);
                widget.onChanged();
              },
            )
          else
            OutlinedButton.icon(
              onPressed: () => setState(() => _addingChoice = true),
              icon: const Icon(FluentIcons.add_24_filled),
              label: const Text("Add Choice"),
              style: _outlinedStyle(context, MenuBuilderColors.kBlue),
            ),
        ],
      ),
    );
  }
}

class _AddChoiceForm extends StatefulWidget {
  const _AddChoiceForm({required this.onCancel, required this.onSave});
  final VoidCallback onCancel;
  final ValueChanged<ChoiceItem> onSave;

  @override
  State<_AddChoiceForm> createState() => _AddChoiceFormState();
}

class _AddChoiceFormState extends State<_AddChoiceForm> {
  final _name = TextEditingController();
  final _price = TextEditingController();
  String? _nameError;
  String? _priceError;

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    super.dispose();
  }

  void _save() {
    final name = _name.text.trim();
    final price = _price.text.trim();
    setState(() {
      _nameError = name.isEmpty ? "Enter item name" : null;
      _priceError =
          double.tryParse(price) == null ? "Enter a valid price" : null;
    });
    if (_nameError != null || _priceError != null) return;
    widget.onSave(ChoiceItem(name: name, price: price));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRoundedTextField(
          borderRadius: BorderRadius.circular(8),
          textEditingController: _name,
          hintText: "Item Name",
          isDense: true,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 8),
        CustomRoundedTextField(
          borderRadius: BorderRadius.circular(8),
          textEditingController: _price,
          hintText: "Item Price",
          isDense: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          onFieldSubmitted: (_) => _save(),
        ),
        const SizedBox(height: 8),
        _FormButtons(onCancel: widget.onCancel, onSave: _save),
      ],
    );
  }
}
