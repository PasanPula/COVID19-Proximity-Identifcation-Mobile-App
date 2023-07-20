import 'package:auto_size_text/auto_size_text.dart';
import '../models/Location.History.Models/location.history_model.dart';
import '../providers/nearby.device.history_provider.dart';
import '../providers/geolist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//********************************************* SCREEEN SHOWS LOCATION HISTORY *********************************

//Use nearby device provider for send data to neaby device screeen and geolist provider for getting location history and operation

class GeoListWidget extends StatefulWidget {
  const GeoListWidget({Key? key}) : super(key: key);

  @override
  GeoListWidgetState createState() => GeoListWidgetState();
}

class GeoListWidgetState extends State<GeoListWidget> {
  @override
  Widget build(BuildContext context) {
    Geolistprovider geolistprovider =
        Provider.of<Geolistprovider>(context, listen: true);
    NearByDeviceprovider nearbyprovider =
        Provider.of<NearByDeviceprovider>(context, listen: true);

//pass geolist details to nearby device provider
    nearByHistory(String date) {
      nearbyprovider.setselectedDate(geolistprovider.formatDate(date));
      nearbyprovider.setStartTime(geolistprovider.formatStartTime(date));
      nearbyprovider.setEndTime(geolistprovider.formatEndTime(date));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_sharp,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: AutoSizeText(
          'Location History',
          style: GoogleFonts.raleway(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.black,
      body: Container(
        // padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<LocationHistoryModel>>(
          future: geolistprovider.fetchGeoHistory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length == 0) {
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: AutoSizeText("Nothing to show \n comeback later",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 24.0),
                      textAlign: TextAlign.start
                      // maxLines: 2,
                      ),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        nearByHistory(snapshot.data![index].trackingTime);
                        Navigator.pushNamed(context, '/nearbyhistory');
                      },
                      child: Card(
                        elevation: 0,
                        color: Colors.white,
                        margin: const EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.location_on_rounded,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 5, 0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                130,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText("Nearby at",
                                                style: GoogleFonts.poppins(
                  
                                                    color:
                                                        Colors.green.shade600,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 16.0),
                                                textAlign: TextAlign.start
                                                // maxLines: 2,
                                                ),
                                            AutoSizeText(
                                              "${snapshot.data![index].address}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0),
                                              // maxLines: 2,
                                            ),
                                            AutoSizeText(
                                              "at ${formatReadeableDate(snapshot.data![index].trackingTime)} on ${formatReadeableTime(snapshot.data![index].trackingTime)}",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14.0),
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ],
                                ),

                                // Text(snapshot.data![index].geo,
                                //     style: const TextStyle(
                                //         fontWeight: FontWeight.normal,
                                //         fontSize: 10.0)),
                              ]),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("Error:${snapshot.error}");
            }
            return Container(
              alignment: AlignmentDirectional.center,
              child: const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
