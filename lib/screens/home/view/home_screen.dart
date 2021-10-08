import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:alekhlas_teachers/screens/home/model/stattistics_model.dart';
import 'package:alekhlas_teachers/screens/home/viewmodel/home_view_model.dart';
import 'package:alekhlas_teachers/screens/home/widgets/card.dart';

import '../../base_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card_params = {
      'height': 150,
      'width': MediaQuery.of(context).size.width * 0.18
    };

    return BaseScreen<HomeViewModel>(
      onModelReady: (viewModel) {},
      builder: (context, viewModel, _) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('statistics')
                      .doc('dashboard')
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      StatisticsModel stat =
                          StatisticsModel.fromDynamic(snapshot.data!.data());
                      return Wrap(
                        children: [
                          AdminCard(
                            card: cards[0],
                            params: card_params,
                            value: stat.services,
                            name: tr('services'),
                          ),
                          AdminCard(
                            card: cards[1],
                            params: card_params,
                            value: stat.customers_count,
                            name: tr('customers'),
                          ),
                          AdminCard(
                            card: cards[1],
                            params: card_params,
                            value: stat.workers_count,
                            name: tr('workers'),
                          ),
                          AdminCard(
                            card: cards[3],
                            params: card_params,
                            value: stat.total_orders,
                            name: tr('orders'),
                          ),
                        ],
                      );
                    }
                    return Text("loading");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var cards = [
  {
    'icon': 0xe148,
  },
  {
    'icon': 0xed14,
  },
  {
    'icon': 0xe04b,
  },
  {
    'icon': 0xe04b,
  }
];
