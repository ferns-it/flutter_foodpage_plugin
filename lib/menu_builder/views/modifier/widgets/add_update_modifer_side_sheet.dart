import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_modifiers_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/responsive_utils.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/menu_builder_app_colors.dart';
import '../../../core/utils/input_formatters.dart';
import '../../../core/utils/ui_utils.dart';
import '../../../core/validators/menu_builder_validators.dart';
import '../../../widgets/custom_rounded_textfield.dart';

class AddUpdateModifierSideSheet extends StatelessWidget {
  const AddUpdateModifierSideSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = context.watch<DishModifiersController>();

    final mq = MediaQuery.of(context);
    final size = mq.size;
    final isMobile = ResponsiveUtils.isMobile(context);

    return SafeArea(
      child: Drawer(
        width: isMobile ? size.width * 0.92 : size.width * 0.4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 14.0 : 20.0,
              vertical: isMobile ? 14.0 : 20.0,
            ),
            child: Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                children: <Widget>[
                  // ---------- Header ----------
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 0.0 : 10.0,
                      ),
                      child: Row(
                        children: [
                          if (isMobile) ...[
                            InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () =>
                                  Scaffold.of(context).closeEndDrawer(),
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Icon(Icons.close),
                              ),
                            ),
                            horizontalSpaceSmall,
                          ],
                          Expanded(
                            child: Text(
                              controller.editMode
                                  ? "Update Modifier"
                                  : "Add Modifier",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: isMobile
                                  ? textTheme.titleMedium
                                  : textTheme.titleLarge,
                            ),
                          ),
                          horizontalSpaceSmall,
                          !controller.isLoading
                              ? InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: () {
                                    controller.addOrUpdateModifier(
                                        onSuccess: () {
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MenuBuilderColors.kBlue
                                          .withOpacity(0.1),
                                    ),
                                    child: const Icon(
                                      Icons.done,
                                      color: MenuBuilderColors.kBlue,
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3.0,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: isMobile ? 28.0 : 40.0),

                  // ---------- Group name ----------
                  CustomRoundedTextField.topText(
                    topText: "Group name",
                    hintText: "Eg Drinks, Salads..",
                    borderRadius: BorderRadius.circular(8.0),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    inputFormatters: const <TextInputFormatter>[
                      NoEmojiTextInputFormatter(),
                    ],
                    textEditingController: controller.groupName,
                    validator: MenuBuilderValidators.validateModifierGroupName,
                  ),
                  verticalSpaceRegular,

                  // ---------- Min / Max ----------
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomRoundedTextField.topText(
                          topText: "Minimum",
                          hintText: "0 (Default)",
                          borderRadius: BorderRadius.circular(8.0),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          fillColor: MenuBuilderColors.kWhite,
                          textEditingController: controller.minimumController,
                          validator: MenuBuilderValidators.validateInteger,
                        ),
                      ),
                      horizontalSpaceRegular,
                      Expanded(
                        child: CustomRoundedTextField.topText(
                          topText: "Maximum",
                          hintText: "0 (Default)",
                          borderRadius: BorderRadius.circular(8.0),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          fillColor: MenuBuilderColors.kWhite,
                          textEditingController: controller.maximumController,
                          validator: MenuBuilderValidators.validateInteger,
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  const Divider(),

                  // ---------- Options ----------
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 0.0 : 10.0,
                      vertical: 5.0,
                    ).copyWith(bottom: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Modifier Options",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.titleMedium,
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.addModifierEntry(),
                              color: Theme.of(context).primaryColor,
                              icon: const Icon(Icons.add, size: 28),
                            )
                          ],
                        ),
                        verticalSpaceSmall,
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.modifierEntries.length,
                          itemBuilder: (context, index) {
                            final entry =
                                controller.modifierEntries.elementAt(index);

                            final nameField = CustomRoundedTextField.topText(
                              topText: "Option name",
                              hintText: "Eg Pepsi, Coca-Cola",
                              borderRadius: BorderRadius.circular(8.0),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              fillColor: MenuBuilderColors.kWhite,
                              textEditingController:
                                  entry["name"] as TextEditingController,
                              validator: MenuBuilderValidators
                                  .validateModifierOptionName,
                              inputFormatters: const <TextInputFormatter>[
                                NoEmojiTextInputFormatter(),
                              ],
                            );

                            final priceField = CustomRoundedTextField.topText(
                              topText: "Price",
                              hintText: "0.00",
                              borderRadius: BorderRadius.circular(8.0),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              fillColor: MenuBuilderColors.kWhite,
                              textEditingController:
                                  entry["price"] as TextEditingController,
                              validator:
                                  MenuBuilderValidators.validateModifierPrice,
                            );

                            final deleteButton = InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () {
                                controller.removeModifierEntry(index);
                              },
                              child: Container(
                                padding: EdgeInsets.all(isMobile ? 10.0 : 8.0),
                                margin: const EdgeInsets.only(top: 20.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: MenuBuilderColors.kPrimaryColor
                                      .withOpacity(0.1),
                                ),
                                child: const Icon(
                                  Icons.delete_forever,
                                  color: MenuBuilderColors.kPrimaryColor,
                                  size: 22,
                                ),
                              ),
                            );

                            if (isMobile) {
                              // Name on its own line, price + delete below.
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  nameField,
                                  verticalSpaceSmall,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: priceField),
                                      horizontalSpaceRegular,
                                      deleteButton,
                                    ],
                                  ),
                                ],
                              );
                            }

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(flex: 2, child: nameField),
                                horizontalSpaceRegular,
                                Expanded(child: priceField),
                                horizontalSpaceRegular,
                                deleteButton,
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return isMobile
                                ? Column(
                                    children: [
                                      verticalSpaceSmall,
                                      Divider(color: Colors.grey.shade300),
                                      verticalSpaceSmall,
                                    ],
                                  )
                                : verticalSpaceRegular;
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
