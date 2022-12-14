import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_team_interval/blocs/drink_details/drink_details_bloc.dart';
import 'package:test_team_interval/data/drink.dart';
import 'package:test_team_interval/view/widgets/custom_chip_list.dart';
import 'package:test_team_interval/view/widgets/custom_loading.dart';
import 'package:test_team_interval/view/widgets/ingredient_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrinkDetailsScreen extends StatelessWidget {
  final String title;
  const DrinkDetailsScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocListener<DrinkDetailsBloc, DrinkDetailsState>(
        listener: (context, state) {
          if (state is DrinkDetailsError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message!),
            ));
          }
        },
        child: BlocBuilder<DrinkDetailsBloc, DrinkDetailsState>(
          builder: (context, state) {
            if (state is DrinkDetailsInitial || state is DrinkDetailsLoading) {
              return _buildLoading();
            } else if (state is DrinkDetailsLoaded) {
              return _buildHome(context, state.drink);
            } else if (state is DrinkDetailsError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildHome(BuildContext context, Drink drink) {
    var imagePreview = '${drink.thumbnail}';
    var title = drink.title.toString();
    var instructions = drink.instructions.toString();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: imagePreview,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
                overflow: TextOverflow.clip,
                maxLines: 3,
              ),
            ),
          ),
          _buildChips(drink.category.toString(), drink.glass.toString(),
              drink.alcholic.toString()),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                instructions,
                style: const TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 17,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          _buildIngredients(drink),
        ],
      ),
    );
  }

  Widget _buildChips(String category, String glass, String alcoholic) =>
      CustomChipList(category: category, glass: glass, alcoholic: alcoholic);

  Widget _buildIngredients(Drink drink) => IngredientList(drink: drink);

  Widget _buildLoading() => const CustomLoading();
}
