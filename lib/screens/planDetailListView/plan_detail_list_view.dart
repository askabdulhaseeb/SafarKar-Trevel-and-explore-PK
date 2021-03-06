import 'package:flutter/material.dart';
import 'package:safarkarappfyp/models/plan.dart';
import 'package:safarkarappfyp/providers/placesproviders.dart';
import 'package:safarkarappfyp/screens/planDetailListView/place_time_detail_card.dart';
import 'package:safarkarappfyp/screens/plannerMapScreen/plan_map_view_screen.dart';
import 'package:safarkarappfyp/screens/widgets/homeAppBar.dart';

class PlanDetailListView extends StatefulWidget {
  static const routeName = '/PlanDetailListView';
  final Map<String, Place> place;
  final Plan plan;
  const PlanDetailListView({@required this.plan, @required this.place});
  @override
  _PlanDetailListViewState createState() => _PlanDetailListViewState();
}

class _PlanDetailListViewState extends State<PlanDetailListView> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.plan?.planName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Interest: ${widget?.plan?.likes ?? 0}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Budget: ${widget?.plan?.budget ?? 0}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                PlaceTimeDetailsCard(
                  place: widget.place[widget?.plan?.departurePlaceID],
                  date:
                      widget?.plan?.departureDate ?? DateTime.now().toString(),
                  time: widget?.plan?.departureTime ?? '12:00',
                ),
                const SizedBox(height: 10),
                PlaceTimeDetailsCard(
                  place: widget.place[widget?.plan?.destinationPlaceID],
                  date: widget?.plan?.returnDate ?? DateTime.now().toString(),
                  time: widget?.plan?.destinationTime ?? '12:00',
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.map),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  PlanMapViewScreen(plan: widget.plan, place: widget.place),
            ),
          );
        },
      ),
    );
  }
}
