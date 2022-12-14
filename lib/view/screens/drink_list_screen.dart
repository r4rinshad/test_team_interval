import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_team_interval/blocs/drink_details/drink_details_bloc.dart';
import 'package:test_team_interval/blocs/drink_list/drink_list_bloc.dart';
import 'package:test_team_interval/data/drink.dart';
import 'package:test_team_interval/view/screens/drink_details_screen.dart';
import 'package:test_team_interval/view/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrinkListScreen extends StatelessWidget {
  final String title;
  const DrinkListScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocListener<DrinkListBloc, DrinkListState>(
        listener: (context, state) {
          if (state is DrinkListError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message!),
            ));
          }
        },
        child: BlocBuilder<DrinkListBloc, DrinkListState>(
          builder: (context, state) {
            if (state is DrinkListInitial || state is DrinkListLoading) {
              return _buildLoading();
            } else if (state is DrinkListLoaded) {
              return _buildHome(context, state.drinks);
            } else if (state is DrinkListError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildHome(BuildContext context, List<Drink> drinks) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: SingleChildScrollView(
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 16,
            runSpacing: 16,
            children: List.generate(drinks.length, (index) {
              var imagePreview = '${drinks[index].thumbnail}';
              var title = drinks[index].title.toString();
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => DrinkDetailsBloc()
                        ..add(SearchByDrinkName(drinkName: title)),
                      child: DrinkDetailsScreen(
                        title: title,
                      ),
                    ),
                  ),
                ),
                child: Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        height: 130,
                        width: MediaQuery.of(context).size.width / 2.5,
                        fit: BoxFit.cover,
                        imageUrl: imagePreview,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.clip,
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => const CustomLoading();
}
