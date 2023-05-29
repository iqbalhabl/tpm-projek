import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:football_league_app/models/league_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Leaguepage extends StatefulWidget {
  const Leaguepage({Key? key}) : super(key: key);

  @override
  State<Leaguepage> createState() => _LeaguepageState();
}

class _LeaguepageState extends State<Leaguepage> {
  final league = Response();
  Future<List<Response>>? leagueResults;
  @override
  void initState() {
    leagueResults = Response.fetchLeagues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Page'),
      ),
      body: Center(
        child: FutureBuilder(
          future: leagueResults,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(5),
                    child: buildCard(
                      snapshot.data?[index].title,
                      snapshot.data?[index].thumbnail,
                      snapshot.data?[index].matchviewUrl,
                      snapshot.data?[index].competition,
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('error : ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildCard(
          String? title, String? image, String? url, String? competition) =>
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: InkWell(
              onTap: () {
                Uri query = Uri.parse(url ?? "No Data");
                _launch(query);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(2),
                    height: 120,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(image ??
                            "https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title ?? "No title",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            competition ?? "no competititon",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Future<void> _launch(Uri url) async {
    String concatenate = url.origin + url.path;
    Uri finalURL = Uri.parse(concatenate);
    try {
      if (await canLaunchUrl(finalURL)) {
        await launchUrl(finalURL);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (kDebugMode) {
        print("error");
      }
    }
  }
}
