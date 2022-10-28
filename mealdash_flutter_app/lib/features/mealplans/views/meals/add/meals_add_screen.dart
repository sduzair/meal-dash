import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealdash_app/features/mealplans/models/meal_model.dart';
import 'package:mealdash_app/features/mealplans/view_models/meal_view_model.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:provider/provider.dart';
import 'package:material_tag_editor/tag_editor.dart';

class MealsAddScreen extends StatefulWidget {
  const MealsAddScreen({Key? key}) : super(key: key);

  @override
  State<MealsAddScreen> createState() => _MealsAddScreenState();
}

class _MealsAddScreenState extends State<MealsAddScreen> {
  File? _imageFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => MealViewModel(),
      builder: (context, child) {
        print('MealsAddScreen build');
        return Scaffold(
          // drawer: const HomeDrawer(),
          appBar: AppBar(
            title: const Text('Add Meal'),
          ),
          body: Theme(
            data: theme.copyWith(
              inputDecorationTheme: theme.inputDecorationTheme.copyWith(
                border: const OutlineInputBorder(),
                isDense: true,
              ),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: constants.defaultPadding),
                children: <Widget>[
                  const SizedBox(height: constants.defaultMargin),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.fastfood),
                      hintText: 'What is the title of the meal?',
                      labelText: 'Meal Title *',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the title of the meal';
                      }
                      return null;
                    },
                    onSaved: (newValue) => context
                        .read<MealViewModel>()
                        .meal
                        .mealTitle = newValue!,
                  ),
                  const SizedBox(height: constants.defaultMargin),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.description),
                      hintText: 'What is the short description of the meal?',
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
                        .read<MealViewModel>()
                        .meal
                        .mealShortDescription = newValue!,
                  ),
                  const SizedBox(height: constants.defaultMargin),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.description),
                      hintText: 'What is the long description of the meal?',
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
                        .read<MealViewModel>()
                        .meal
                        .mealLongDescription = newValue!,
                  ),
                  const SizedBox(height: constants.defaultMargin),
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
                  // const SizedBox(height: constants.defaultMargin),
                  Center(
                    child: Material(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(constants.borderRadius)),
                      ),
                      child: InkWell(
                        onTap: () =>
                            _showPhotoPickerOptionsBottomModal(context),
                        child: _imageFile == null
                            ? const ImagePlaceholderWidget()
                            : Ink(
                                height: 200,
                                width: 200 * (6 / 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      constants.borderRadius),
                                  image: DecorationImage(
                                    image: FileImage(_imageFile!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
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
                              .read<MealViewModel>()
                              .meal
                              .mealQuantity = int.parse(newValue!),
                        ),
                      ),
                      const SizedBox(width: constants.defaultMargin),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Unit *',
                          ),
                          value: context
                              .watch<MealViewModel>()
                              .meal
                              .mealQuantityUnit,
                          items: MealQuantityUnit.values
                              .map((MealQuantityUnit unit) {
                            return DropdownMenuItem<String>(
                              value: unit.name,
                              child: Text(unit.name),
                            );
                          }).toList(),
                          onChanged: (String? newValue) => context
                              .read<MealViewModel>()
                              .meal
                              .mealQuantityUnit = newValue!,
                          onSaved: (newValue) => context
                              .read<MealViewModel>()
                              .meal
                              .mealQuantityUnit = newValue!,
                        ),
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
                    onSaved: (newValue) =>
                        context.read<MealViewModel>().meal.mealCalories =
                            newValue != null ? int.parse(newValue) : null,
                  ),
                  const SizedBox(height: constants.defaultMargin),
                  AddMealSubmitButton(formKey: _formKey),
                  const SizedBox(height: constants.defaultMargin),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class IngredientsChipsTextField extends StatelessWidget {
  const IngredientsChipsTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('IngredientsChipsTextField rebuild');
    return TagEditor(
      length: context.watch<MealViewModel>().meal.mealIngredients!.length,
      delimiters: const [',', ' '],
      hasAddButton: true,
      inputDecoration: const InputDecoration(
        hintText: 'Add ingredients*',
      ),
      onTagChanged: (newValue) {
        // setState(() {
        context.read<MealViewModel>().addIngredient(ingredient: newValue);
        // });
      },
      tagBuilder: (context, index) {
        print('IngredientsChipsTextField TagBuilder build');
        return Chip(
          // labelPaddin: const EdgeInsets.only(left: 8.0),
          label: Text(
              context.watch<MealViewModel>().meal.mealIngredients![index],
              textScaleFactor: 1.1),
          deleteIcon: const Icon(
            Icons.close,
            // size: 18,
            size: constants.defaultIconSizeSmall,
          ),
          deleteButtonTooltipMessage:
              'Remove ${context.watch<MealViewModel>().meal.mealIngredients![index]}',
          onDeleted: () =>
              context.read<MealViewModel>().removeIngredientAt(index: index),
        );
      },
    );
  }
}

class AddMealSubmitButton extends StatelessWidget {
  const AddMealSubmitButton({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    print('AddMealSubmitButton build');
    return ElevatedButton(
      child: const AddMealSubmitButtonText(),
      onPressed: () {
        if (context.read<MealViewModel>().isAddingMeal) {
          return;
        }
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
        }
        context.read<MealViewModel>().addMeal();
        if (context.read<MealViewModel>().isAddingMealSuccess) {
          Navigator.of(context).pop();
        }
        // Navigator.of(context).pop();
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
    return Consumer<MealViewModel>(
      builder: (context, mealViewModel, child) {
        if (mealViewModel.isAddingMeal) {
          return const CircularProgressIndicator();
        } else if (mealViewModel.isAddingMealSuccess) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Added Meal'),
              SizedBox(width: 10),
              Icon(Icons.check),
            ],
          );
        } else if (mealViewModel.isAddingMealError) {
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
              const Divider(),
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
