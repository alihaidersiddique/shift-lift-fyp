import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/utils.dart';
import '../home_screen.dart';

class VehicleListTile extends ConsumerWidget {
  const VehicleListTile({
    Key? key,
    required this.image,
    required this.name,
    required this.weight,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  final String image;
  final String name;
  final String weight;
  final VoidCallback onTap;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTileValue = ref.watch(selectedTileProvider);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            width: 2,
            color: selectedTileValue == index
                ? AppColors.primaryColor
                : Colors.transparent,
          ),
        ),
        child: ListTile(
          tileColor: AppColors.secondaryColor,
          leading: Image.asset(image),
          title: Text(name),
          subtitle: Text(weight),
        ),
      ),
    );
  }
}
