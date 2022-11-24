import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealdash_app/features/meals/dtos/meal_dto.dart';
import 'package:mealdash_app/features/meals/repository/meal_service.dart';
import 'package:mealdash_app/features/meals/view_models/meal_add_view_model.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:provider/provider.dart';
import 'package:material_tag_editor/tag_editor.dart';

class MealsEditScreen extends StatefulWidget {
  final int mealId;
  const MealsEditScreen({Key? key, required this.mealId}) : super(key: key);

  @override
  State<MealsEditScreen> createState() => _MealsEditScreenState();
}

class _MealsEditScreenState extends State<MealsEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // print(context.read<MealViewModel>().meal.toJson());
    return Scaffold(
      // drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text('Edit Meal'),
      ),
      body: Theme(
        data: theme.copyWith(
          inputDecorationTheme: theme.inputDecorationTheme.copyWith(
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
        child: FutureBuilder<MealDTOWithId>(
          future: context.read<MealService>().fetchMealById(widget.mealId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.all(constants.defaultPadding),
                children: [
                  const Center(
                    child: ImageWidget(),
                  ),
                  const SizedBox(height: constants.defaultMargin),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: constants.defaultMargin),
                        TextFormField(
                          restorationId: 'mealName',
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.fastfood),
                            hintText: 'What is the title of the meal?',
                            labelText: 'Meal Title *',
                          ),
                          // onEditingComplete: () => ,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the title of the meal';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            context.read<MealAddViewModel>().mealDTO.mealTitle =
                                newValue!;
                            print(
                              'mealTitle: ${context.read<MealAddViewModel>().mealDTO.mealTitle}',
                            );
                          },
                        ),
                        const SizedBox(height: constants.defaultMargin),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.description),
                            hintText:
                                'What is the short description of the meal?',
                            labelText: 'Short Description *',
                          ),
                          minLines: 2,
                          maxLines: 2,
                          // expands: true,
                          keyboardType: TextInputType.multiline,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the description of the meal';
                            }
                            return null;
                          },
                          onSaved: (newValue) => context
                              .read<MealAddViewModel>()
                              .mealDTO
                              .mealShortDescription = newValue!,
                        ),
                        const SizedBox(height: constants.defaultMargin),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.description),
                            hintText:
                                'What is the long description of the meal?',
                            labelText: 'Long Description *',
                          ),
                          minLines: 4,
                          maxLines: null,
                          // expands: true,
                          keyboardType: TextInputType.multiline,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the description of the meal';
                            }
                            return null;
                          },
                          onSaved: (newValue) => context
                              .read<MealAddViewModel>()
                              .mealDTO
                              .mealLongDescription = newValue!,
                        ),
                        // const SizedBox(height: constants.defaultMargin),
                        // field for meal price input (double)
                        // TextFormField(
                        //   controller: _mealPriceController,
                        //   decoration: const InputDecoration(
                        //     prefixIcon: Icon(Icons.attach_money),
                        //     hintText: 'What is the price of the meal?',
                        //     labelText: 'Meal Price *',
                        //   ),
                        //   inputFormatters: [
                        //     CurrencyTextInputFormatter(
                        //       locale: 'en_CA',
                        //       decimalDigits: 2,
                        //     ),
                        //   ],
                        //   keyboardType: TextInputType.number,
                        //   validator: (String? value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter the price of the meal';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        const SizedBox(height: constants.defaultMargin),
                        // form for taking arrat of ingredients as input
                        const IngredientsChipsTextField(),
                        const SizedBox(height: constants.defaultMargin),
                        // input for meal weight in ounces or milliliters (double) (dropdown) (ounces by default)
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.fastfood),
                                  hintText: 'What is the quantity of the meal?',
                                  labelText: 'Meal Quantity *',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the quantity of the meal';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) => context
                                    .read<MealAddViewModel>()
                                    .mealDTO
                                    .mealQuantity = int.parse(newValue!),
                              ),
                            ),
                            const SizedBox(width: constants.defaultMargin),
                            const Expanded(
                              child: MealQuantityUnitDropDown(),
                            ),
                          ],
                        ),
                        const SizedBox(height: constants.defaultMargin),
                        // optional input for meal calories with a unit of calories (double)
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.whatshot),
                            hintText: 'What is the calorie count of the meal?',
                            labelText: 'Meal Calories',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onSaved: (newValue) {
                            if (newValue != null && newValue.isNotEmpty) {
                              context
                                  .read<MealAddViewModel>()
                                  .mealDTO
                                  .mealCalories = int.parse(newValue);
                            }
                          },
                        ),
                        const SizedBox(height: constants.defaultMargin),
                        const AddMealSubmitButton(),
                        const SizedBox(height: constants.defaultMargin),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ImageWidget build');
    // final imageFile = context.watch<MealViewModel>().image;
    File? imageFile;
    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(constants.borderRadius)),
      ),
      child: InkWell(
        onTap: () => _showPhotoPickerOptionsBottomModal(context),
        child: imageFile == null
            ? const ImagePlaceholderWidget()
            : Ink(
                height: 200,
                width: 200 * (6 / 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(constants.borderRadius),
                  image: DecorationImage(
                    image: FileImage(imageFile),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      ),
    );
  }
}

class MealQuantityUnitDropDown extends StatelessWidget {
  const MealQuantityUnitDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('MealQuantityUnitDropDown build');
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Unit *',
      ),
      value: context.read<MealAddViewModel>().mealDTO.mealQuantityUnit,
      items: MealQuantityUnit.values
          .map(
            (MealQuantityUnit unit) => DropdownMenuItem<String>(
              value: unit.name,
              child: Text(unit.name),
            ),
          )
          .toList(),
      onChanged: (String? newValue) =>
          context.read<MealAddViewModel>().mealDTO.mealQuantityUnit = newValue!,
      onSaved: (newValue) =>
          context.read<MealAddViewModel>().mealDTO.mealQuantityUnit = newValue!,
    );
  }
}

class IngredientsChipsTextField extends StatelessWidget {
  const IngredientsChipsTextField({super.key});

  @override
  Widget build(BuildContext context) {
    print('IngredientsChipsTextField rebuild');
    var ingredientsProviderWatch = context.watch<IngredientsProviderEdit>();
    return TagEditor(
      length: ingredientsProviderWatch.ingredients.length,
      delimiters: const [',', ' '],
      hasAddButton: true,
      inputDecoration: InputDecoration(
        hintText: 'Add ingredients*',
        errorText: ingredientsProviderWatch.isAddingIngredients
            ? null
            : ingredientsProviderWatch.ingredients.isEmpty
                ? 'Please add at least one ingredient'
                : null,
      ),
      onTagChanged: (newValue) =>
          context.read<IngredientsProviderEdit>().addIngredient(newValue),
      tagBuilder: (context, index) {
        print('IngredientsChipsTextField TagBuilder build');
        return Chip(
          // labelPaddin: const EdgeInsets.only(left: 8.0),
          label: Text(
            context.read<IngredientsProviderEdit>().ingredients[index],
            textScaleFactor: 1.1,
          ),
          deleteIcon: const Icon(
            Icons.close,
            // size: 18,
            size: constants.defaultIconSizeSmall,
          ),
          deleteButtonTooltipMessage:
              'Remove ${context.read<IngredientsProviderEdit>().ingredients[index]}',
          onDeleted: () => context
              .read<IngredientsProviderEdit>()
              .removeIngredient(index: index),
          // setState(() => widget.meal.mealIngredients.removeAt(index)),
        );
      },
    );
  }
}

class AddMealSubmitButton extends StatefulWidget {
  const AddMealSubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  State<AddMealSubmitButton> createState() => _AddMealSubmitButtonState();
}

class _AddMealSubmitButtonState extends State<AddMealSubmitButton> {
  @override
  Widget build(BuildContext context) {
    print('AddMealSubmitButton build');
    final mealVMWatch = context.watch<MealAddViewModel>();
    final ingredientsProviderWatch = context.watch<IngredientsProviderEdit>();
    final formKey = Form.of(context);
    return ElevatedButton(
      child: const AddMealSubmitButtonText(),
      onPressed: () {
        print(mealVMWatch.mealDTO.toJson());
        if (mealVMWatch.isAddingMeal) {
          return;
        }

        ingredientsProviderWatch.isAddingIngredients = false;

        if (!constants.isTestingMealAdd &&
            formKey!.validate() &&
            ingredientsProviderWatch.ingredients.isNotEmpty) {
          print(
            'formKey.validate() && ingredientsProviderWatch.ingredients.isNotEmpty',
          );
          context.read<MealAddViewModel>().mealDTO.mealIngredients =
              ingredientsProviderWatch.ingredients;
          formKey.save();
        }
        context.read<MealAddViewModel>().addMeal();
        if (mealVMWatch.isAddingMealSuccess) {
          Navigator.of(context).pop();
        }
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Processing Data')),
        // );
      },
    );
  }
}

class AddMealSubmitButtonText extends StatelessWidget {
  const AddMealSubmitButtonText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('AddMealSubmitButtonText build');
    return Consumer<MealAddViewModel>(
      builder: (context, meal, child) {
        if (meal.isAddingMeal) {
          return const CircularProgressIndicator();
        } else if (meal.isAddingMealSuccess) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Added Meal'),
              SizedBox(width: 10),
              Icon(Icons.check),
            ],
          );
        } else if (meal.isAddingMealError) {
          // return error message with icon button to retry adding meal
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Error Adding Meal'),
              SizedBox(width: 10),
              Icon(Icons.refresh),
            ],
          );
        } else {
          // return add meal text with icon button to add meal
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Add Meal'),
              SizedBox(width: 10),
              Icon(Icons.add),
            ],
          );
        }
      },
    );
  }
}

class ImagePlaceholderWidget extends StatelessWidget {
  const ImagePlaceholderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(constants.borderRadius),
      dashPattern: const [5, 5],
      strokeCap: StrokeCap.round,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Ink(
        height: 200,
        width: 200 * (6 / 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(constants.borderRadius),
          image: const DecorationImage(
            image: AssetImage('assets/images/image_placeholder.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

enum ImageState {
  free,
  picked,
  cropped,
}

void _showPhotoPickerOptionsBottomModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    // shape: const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.vertical(
    //     top: Radius.circular(constants.borderRadius),
    //   ),
    // ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize:
          constants.defaultDraggableScrollableSheetInitialChildSizeSmall,
      maxChildSize: constants.defaultDraggableScrollableSheetMaxChildSizeSmall,
      minChildSize: constants.defaultDraggableScrollableSheetMinChildSizeSmall,
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Container(
          padding: const EdgeInsets.all(constants.defaultPadding),
          child: Column(
            children: [
              const Divider(
                indent: 50,
                endIndent: 50,
              ),
              const SizedBox(height: constants.defaultMargin),
              const Text(
                'Select Photo',
                style: TextStyle(
                  fontSize: constants.defaultFontSizeXLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: constants.defaultMargin),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      // await _pickImage(ImageSource.camera, context);
                    },
                    child: Column(
                      children: const [
                        Icon(
                          Icons.camera_alt,
                          size: constants.defaultIconSizeXXXXXLarge,
                        ),
                        SizedBox(height: constants.defaultMarginSmall),
                        Text('Camera'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      //  await _pickImage(ImageSource.gallery, context);
                    },
                    child: Column(
                      children: const [
                        Icon(
                          Icons.photo,
                          size: constants.defaultIconSizeXXXXXLarge,
                        ),
                        SizedBox(height: constants.defaultMarginSmall),
                        Text('Gallery'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<File?> _pickImage(ImageSource source, BuildContext context) async {
  final XFile image;
  File? img;
  try {
    image = (await ImagePicker().pickImage(source: source))!;
    if (image == null) return null;
    img = File(image.path);
    img = await _cropImage(imageFile: img);
  } on PlatformException catch (e) {
    print(e);
  } finally {
    Navigator.of(context).pop();
  }
  return img;
}

Future<File?> _cropImage({required File imageFile}) async {
  CroppedFile? croppedImage =
      await ImageCropper().cropImage(sourcePath: imageFile.path);
  if (croppedImage == null) return null;
  return File(croppedImage.path);
}
