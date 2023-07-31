import 'package:flora/constans/space.dart';
import 'package:flora/db.dart';
import 'package:flora/models/product_model.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/card/product_favorite_card.dart';
import 'package:flutter/material.dart';

class ProfileFavoriteScreen extends StatefulWidget {
  const ProfileFavoriteScreen({super.key});

  @override
  State<ProfileFavoriteScreen> createState() => _ProfileFavoriteScreenState();
}

class _ProfileFavoriteScreenState extends State<ProfileFavoriteScreen> {
  List<ProductModel> items = DB.getFlowers().sublist(0, 6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppHeader('Yêu thích'),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));

          setState(() {
            items = DB.getFlowers(shuffle: true);
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSpace.xl),
          child: ListView.separated(
            itemBuilder: (context, index) => ProductFavoriteCard(items[index]),
            separatorBuilder: (_, __) => const SizedBox(height: AppSpace.xl),
            itemCount: items.length,
          ),
        ),
      ),
    );
  }
}
