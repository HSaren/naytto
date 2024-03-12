import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naytto/src/features/authentication/domain/app_user.dart';
import 'package:naytto/src/features/booking/data/ollinbookingrepo.dart';
import 'package:naytto/src/features/booking/domain/ollinsaunabookings.dart';

class SaunaScreen extends ConsumerWidget {
  const SaunaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saunaDataAsyncValue = ref.watch(saunaDataStreamProvider);
    final saunaDataUpdate = ref.read(saunaDataUpdateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sauna Booking'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: saunaDataAsyncValue.when(
          data: (saunaDataList) {
            return ListView.builder(
              itemCount: saunaDataList.length,
              itemBuilder: (context, index) {
                final booking = saunaDataList[index];
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 30,
                      // mainAxisExtent: 300),
                      childAspectRatio: 0.6),
                  itemCount: booking.fields.length,
                  itemBuilder: (context, idx) {
                    final entry = booking.fields.entries.toList()[idx];
                    final fieldName = entry.key;
                    final fieldValue = entry.value;
                    String weekDay = '';
                    if (fieldName == '1') weekDay = "Monday";
                    if (fieldName == '2') weekDay = "Tuesday";
                    if (fieldName == '3') weekDay = "Wednesday";
                    if (fieldName == '4') weekDay = "Thursday";
                    if (fieldName == '5') weekDay = "Friday";
                    if (fieldName == '6') weekDay = "Saturday";
                    if (fieldName == '7') weekDay = "Sunday";

                    return Column(
                      children: [
                        Text(
                          weekDay,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ...fieldValue.entries.map((fieldEntry) {
                          String time = fieldEntry.key;
                          bool available = fieldEntry.value;

                          return Expanded(
                            child: Container(
                              margin: EdgeInsets.all(4),
                              // padding: EdgeInsets.all(1),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        7.0), // Määritä pyöristyksen koko
                                  ),
                                  side: BorderSide(
                                    color: Color.fromARGB(78, 16, 3, 3),
                                    width: 2.0,
                                  ),
                                  minimumSize: Size(200, 0),
                                  backgroundColor: available
                                      ? Color.fromARGB(255, 126, 241, 130)
                                      : Color.fromARGB(210, 255, 138, 66),
                                ),
                                onPressed: () async {
                                  final bool? confirm = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Change Booking'),
                                        content: Text(
                                            'Are you sure you want to change your saunas time?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: Text('Yes'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (confirm ?? false) {
                                    try {
                                      await saunaDataUpdate.updateSaunaData(
                                          booking.id,
                                          fieldName,
                                          time,
                                          available,
                                          weekDay);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Error updating sauna data',
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  '$time:00-${int.parse(time) + 1}:00',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  },
                );
              },
            );
          },
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text('Error: $error'),
          ),
        ),
      ),
    );
  }
}
