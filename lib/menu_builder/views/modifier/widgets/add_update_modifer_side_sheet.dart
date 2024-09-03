import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_modifiers_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/menu_builder_app_colors.dart';
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
    final bottom = mq.viewInsets.bottom;

    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        height: size.height - bottom,
        child: SafeArea(
          child: Drawer(
            width: size.width * 0.4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Form(
                  key: controller.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: ListView(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  controller.editMode
                                      ? "Update Modifier"
                                      : "Add Modifier",
                                  style: textTheme.titleLarge),
                              InkWell(
                                onTap: () => controller.addOrUpdateModifier(
                                    onSuccess: () {
                                  Navigator.pop(context);
                                }),
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MenuBuilderColors.kBlue
                                        .withOpacity(0.25),
                                  ),
                                  child: const Icon(
                                    Icons.done,
                                    color: MenuBuilderColors.kBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 40.0),
                      CustomRoundedTextField.topText(
                        topText: "Group name",
                        hintText: "Eg Drinks, Salads..",
                        borderRadius: BorderRadius.circular(8.0),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textEditingController: controller.groupName,
                        validator:
                            MenuBuilderValidators.validateModifierGroupName,
                      ),
                      verticalSpaceRegular,
                      Row(
                        children: [
                          Expanded(
                            child: CustomRoundedTextField.topText(
                              topText: "Minimum",
                              hintText: "0 (Default)",
                              borderRadius: BorderRadius.circular(8.0),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              fillColor: MenuBuilderColors.kWhite,
                              textEditingController:
                                  controller.minimumController,
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
                              textEditingController:
                                  controller.maximumController,
                              validator: MenuBuilderValidators.validateInteger,
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceSmall,
                      const Divider(),
                      SizedBox(
                        height: bottom != 0.0
                            ? size.height * 0.7
                            : size.height * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ).copyWith(bottom: 20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Modifier Options",
                                    style: textTheme.titleMedium,
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        controller.addModifierEntry(),
                                    color: Theme.of(context).primaryColor,
                                    icon: const Icon(Icons.add, size: 28),
                                  )
                                ],
                              ),
                              verticalSpaceSmall,
                              Expanded(
                                child: ListView.separated(
                                  itemCount: controller.modifierEntries.length,
                                  itemBuilder: (context, index) {
                                    final entry = controller.modifierEntries
                                        .elementAt(index);
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: CustomRoundedTextField.topText(
                                            topText: "Option name",
                                            hintText: "Eg Pepsi, Coca-Cola",
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            keyboardType: TextInputType.name,
                                            textInputAction:
                                                TextInputAction.next,
                                            fillColor: MenuBuilderColors.kWhite,
                                            textEditingController: entry["name"]
                                                as TextEditingController,
                                            validator: MenuBuilderValidators
                                                .validateModifierOptionName,
                                          ),
                                        ),
                                        horizontalSpaceRegular,
                                        Expanded(
                                          child: CustomRoundedTextField.topText(
                                            topText: "Price",
                                            hintText: "£0.00",
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.done,
                                            fillColor: MenuBuilderColors.kWhite,
                                            textEditingController:
                                                entry["price"]
                                                    as TextEditingController,
                                            validator: MenuBuilderValidators
                                                .validateModifierPrice,
                                          ),
                                        ),
                                        horizontalSpaceRegular,
                                        InkWell(
                                          onTap: () {
                                            controller
                                                .removeModifierEntry(index);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            margin: const EdgeInsets.only(
                                                top: 20.0),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: MenuBuilderColors
                                                  .kPrimaryColor
                                                  .withOpacity(0.25),
                                            ),
                                            child: const Icon(
                                              Icons.delete_forever,
                                              color: MenuBuilderColors
                                                  .kPrimaryColor,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return verticalSpaceRegular;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
