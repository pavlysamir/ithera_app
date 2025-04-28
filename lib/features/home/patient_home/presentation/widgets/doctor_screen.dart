import 'package:flutter/material.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: CustomSvgimage(
                hight: 200,
                path: AssetsData.onBording_2,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Doctor ${index + 1}'),
                  subtitle: Text('Specialization ${index + 1}'),
                );
              },
              childCount: 20, // Number of doctors
            ),
          ),
        ],
      ),
    );
  }
}
