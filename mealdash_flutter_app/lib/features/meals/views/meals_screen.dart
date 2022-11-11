import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';
import 'package:mealdash_app/features/meals/models/meal_model.dart';
import 'package:mealdash_app/features/meals/repository/meal_service.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                GoRouter.of(context).goNamed(constants.mealsAddRouteName),
          ),
        ],
      ),
      // {mealTitle: sadf, mealShortDescription: asdf, mealLongDescription: afds, mealIngredients: [34sdf, sadf], mealCalories: null, mealQuantity: 234, mealQuantityUnit: oz}

      // body displaying meals with mealTitle, mealShortDescription, mealIngredients, mealCalories, mealQuantity, mealQuantityUnit

      body: const MealsFutureBuilder(),

      // body: const Center(
      //   child: Text('Meals'),
      // ),
    );
  }
}

class MealsFutureBuilder extends StatefulWidget {
  const MealsFutureBuilder({Key? key}) : super(key: key);

  @override
  State<MealsFutureBuilder> createState() => _MealsFutureBuilderState();
}

class _MealsFutureBuilderState extends State<MealsFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    if (context.read<UserAuthViewModel>().isShowLoggingInSuccessPopup) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successfull'),
          ),
        );
      });
    }
    return FutureBuilder<List<MealModelWithId>>(
      future: MealService.getMeals(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: 4),
                  isThreeLine: true,
                  leading: AspectRatio(
                    aspectRatio: 6.0 / 5.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff7c94b6),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  title: Text(snapshot.data![index].mealTitle!),
                  subtitle: Text(snapshot.data![index].mealShortDescription!),
                  trailing: PopupMenuButton<String>(
                    onSelected: (String value) {
                      if (value == 'Details') {
                        GoRouter.of(context)
                            .goNamed(constants.mealsDetailRouteName);
                      } else if (value == 'Edit') {
                        GoRouter.of(context).goNamed(
                          constants.mealsEditRouteName,
                          params: {'id': snapshot.data![index].mealId},
                        );
                      } else if (value == 'Delete') {
                        // MealService.deleteMeal(snapshot.data![index].id!);
                        // setState(() {});
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Details',
                          child: Row(
                            children: const [
                              Icon(Icons.info, color: Colors.black),
                              SizedBox(width: constants.defaultPaddingXSmall),
                              Text('Details'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'Edit',
                          child: Row(
                            children: const [
                              Icon(Icons.edit, color: Colors.blue),
                              SizedBox(width: constants.defaultPaddingXSmall),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'Delete',
                          child: Row(
                            children: const [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: constants.defaultPaddingXSmall),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                  // trailing: DropdownButton<String>(
                  //   // selectedItemBuilder: (BuildContext context) {
                  //   //   return snapshot.data!.map((MealModelWithId meal) {
                  //   //     return Text(meal.mealQuantity.toString());
                  //   //   }).toList();
                  //   // },
                  //   underline: Container(height: 0),
                  //   icon: const Icon(Icons.more_vert),
                  //   items: <String>['Details', 'Edit', 'Delete']
                  //       .map((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  //   onChanged: (String? value) {
                  //     if (value == 'Details') {
                  //       GoRouter.of(context).goNamed(
                  //         constants.mealsDetailRouteName,
                  //         params: {'id': snapshot.data![index].mealId},
                  //       );
                  //     } else if (value == 'Edit') {
                  //       GoRouter.of(context).goNamed(
                  //         constants.mealsEditRouteName,
                  //         params: {'id': snapshot.data![index].mealId},
                  //       );
                  //     } else if (value == 'Delete') {
                  //       // MealService.deleteMeal(snapshot.data![index].id!);
                  //       // setState(() {});
                  //     }
                  //   },
                  // ),
                ),
              );
              // return Card(
              //   child: CustomListItemTwo(
              //     thumbnail: Container(
              //       decoration: const BoxDecoration(
              //         color: Color(0xff7c94b6),
              //         image: DecorationImage(
              //           image: NetworkImage(
              //               'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
              //           fit: BoxFit.cover,
              //         ),
              //         // border: Border.all(
              //         //   width: 8,
              //         // ),
              //         // borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //     title: snapshot.data![index].mealTitle!,
              //     subtitle: snapshot.data![index].mealShortDescription!,
              //     author: 'author',
              //     publishDate: 'publishDate',
              //     readDuration: 'readDuration',
              //   ),
              // );
            },
          );
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// class MoreOptions extends StatelessWidget {
//   const MoreOptions({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<String>(
//       onSelected: (String value) {
//         if (value == 'Details') {
//           GoRouter.of(context).goNamed(constants.mealsDetailRouteName);
//         } else if (value == 'Edit') {
//           GoRouter.of(context).goNamed(constants.mealsEditRouteName);
//         } else if (value == 'Delete') {
//           // MealService.deleteMeal(snapshot.data![index].id!);
//           // setState(() {});
//         }
//       },
//       itemBuilder: (BuildContext context) {
//         return <PopupMenuEntry<String>>[
//           const PopupMenuItem<String>(
//             value: 'Details',
//             child: Text('Details'),
//           ),
//           const PopupMenuItem<String>(
//             value: 'Edit',
//             child: Text('Edit'),
//           ),
//           const PopupMenuItem<String>(
//             value: 'Delete',
//             child: Text('Delete'),
//           ),
//         ];
//       },
//     );
//   }
// }

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  });

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate - $readDuration',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  const CustomListItemTwo({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  });

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 6.0 / 5.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
