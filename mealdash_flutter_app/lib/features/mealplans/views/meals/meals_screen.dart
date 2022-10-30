import 'package:mealdash_app/features/mealplans/models/meal_model.dart';
import 'package:mealdash_app/features/mealplans/repository/meal_service.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

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
    return FutureBuilder<List<MealModelWithId>>(
      future: MealService.getMeals(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: CustomListItemTwo(
                  thumbnail: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        width: 8,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  title: snapshot.data![index].mealTitle!,
                  subtitle: snapshot.data![index].mealShortDescription!,
                  author: 'author',
                  publishDate: 'publishDate',
                  readDuration: 'readDuration',
                ),
              );
              // return Card(
              //   child: ListTile(
              //     title: Text(snapshot.data![index].mealTitle!),
              //     subtitle: Text(snapshot.data![index].mealShortDescription!),
              //     // onTap: () => GoRouter.of(context).goNamed(
              //     //   constants.mealsDetailRouteName,
              //     //   pathParams: {'mealId': snapshot.data![index].mealId},
              //     // ),
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
