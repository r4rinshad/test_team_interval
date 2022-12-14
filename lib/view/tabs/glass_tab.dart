import 'package:test_team_interval/blocs/glass/glass_bloc.dart';
import 'package:test_team_interval/data/drink.dart';
import 'package:test_team_interval/view/widgets/custom_list_tile.dart';
import 'package:test_team_interval/view/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlassTab extends StatefulWidget {
  const GlassTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GlassTabState();
}

class _GlassTabState extends State<GlassTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => GlassBloc()..add(GetAllGlasses()),
      child: BlocListener<GlassBloc, GlassState>(
        listener: (context, state) {
          if (state is GlassError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message!),
            ));
          }
        },
        child: BlocBuilder<GlassBloc, GlassState>(
          builder: (context, state) {
            if (state is GlassInitial || state is GlassLoading) {
              return _buildLoading();
            } else if (state is GlassLoaded) {
              return _buildHome(state.glasses, DrinkFieldType.glass);
            } else if (state is GlassError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildHome(List<Drink> list, DrinkFieldType drinkFieldType) =>
      CustomListTile(
        list: list,
        drinkFieldType: drinkFieldType,
      );

  Widget _buildLoading() => const CustomLoading();
}
