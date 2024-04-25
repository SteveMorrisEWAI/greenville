import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/utilities/get_uri.dart';
import 'package:aiseek/data/models/previous_search.dart';
import 'package:aiseek/data/dataproviders/previous_searches_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:aiseek/presentation/widgets/saved_search_card.dart';

import '../widgets/bottom_navigation.dart';

// TODO Flesh out Linked Results Page
class PreviousSearchesPage extends StatefulWidget {
  PreviousSearchesPage({Key? key}) {
    Globals.printDebug(inText: 'B4 Init state PreviousSearchesPage key is ${key.toString()}');
  }

  @override
  PreviousSearchesPageState createState() => PreviousSearchesPageState();
}

enum MyMenuItems { Settings, Clear, ViewSearch, NewSearch }

class PreviousSearchesPageState extends State<PreviousSearchesPage> {
  var psMap;
  var textSearch;
  @override
  void initState() {
    Globals.setLastPage(AppConstants.resultsRouteName);
    Globals.printDebug(inText: 'PreviousSearchesPage B4 Get PreviousSearches() initState psMap = ${psMap.toString()}');
    SetupOtherURIs();
    psMap = getPreviousSearches();
    previousSearchFuture = psMap;
    textSearch = '';
    super.initState();
  }

  ///1. Load JSON data from api
//  Future<List<PreviousSearch>> previousSearchFuture = getPreviousSearches();

  Future<List<PreviousSearch>> getPreviousSearches() async {
    PreviousSearchesProvider previousSearchesProvider = PreviousSearchesProvider();
    List<PreviousSearch> myMap = await previousSearchesProvider.getData();
    Globals.printDebug(inText: 'PreviousSearchesPage PreviousSearchesProvider() myMap.length = ${myMap.length.toString()}');
    return myMap;
  }

  Future deleteAllSearches() async {
    bool request = await PreviousSearchesProvider().deleteAllSearches();
    if (request) {
      setState(() {
        previousSearchFuture = getPreviousSearches();
      });
    }
  }

  Future deleteIndividualSearch(convId) async {
    bool request = await PreviousSearchesProvider().deleteSearch(convId);
    
    if (request) {
      setState(() {
        previousSearchFuture = getPreviousSearches();
      });
    }
  }

  Future<List<PreviousSearch>> searchSearches(text) async {
    PreviousSearchesProvider previousSearchesProvider = PreviousSearchesProvider();
    List<PreviousSearch> myMap = await previousSearchesProvider.doSearch(text);
    Globals.printDebug(inText: 'PreviousSearchesPage PreviousSearchesProvider() myMap.length = ${myMap.length.toString()}');
    return myMap;
  }

  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    final defaultColorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          flexibleSpace: Container(decoration: BoxDecoration(color: defaultColorScheme.background)),
          title: Text(AppConstants.previousSearchesResultsTitle, style: TextStyle(
            color: defaultColorScheme.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.delete, color: defaultColorScheme.onBackground),
              tooltip: 'Clear Previous Searches',
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Are you sure you want to delete all the items in your history?'),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Globals.endGradient)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              SizedBox(width: 10,),
                              TextButton(
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Globals.endGradient), foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                                onPressed: () {
                                  deleteAllSearches();
                                  Navigator.pop(context);
                                },
                                child: const Text('Confirm'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ),
          ]
        ),
        bottomNavigationBar: BottomNavWidget(),
        body: Container( 
          decoration: BoxDecoration(
            color: defaultColorScheme.background
          ),
          child:
            Column(
              children: [
              Row(children: [
                  Container( width: deviceWidth, child: 
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: 
                      TextField(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        autofocus: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Globals.bottomNavTextColour),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Globals.bottomNavTextColour),
                            borderRadius: BorderRadius.all(Radius.circular(7))
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide(color: Globals.endGradient),
                          ),
                          hintText: 'Search your history...'
                        ),
                        onChanged: (text)=> setState(() {
                          previousSearchFuture = searchSearches(text);
                        }),
                      ),
                    ),
                  ),
                ],),
                Expanded( child:
                Center(
                  child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: FutureBuilder<List<PreviousSearch>>(
                      future: previousSearchFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            '😞 ${snapshot.error}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          );
                        } else if (snapshot.hasData) {
                          final previousSearches = snapshot.data!;
                          if (previousSearches.isEmpty) {
                            return Column( 
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                              Image.asset('assets/images/bottomnav_history.png', width: 50,),
                              SizedBox(height: 10,),
                              Text(
                              'No previous searches found.',
                              style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ]);
                          } else {
                            return buildPreviousSearches(previousSearches, deleteIndividualSearch);
                          }
                        } else {
                          return Text(
                            'No user data.',
                            style: Theme.of(context).textTheme.bodyLarge,
                          );
                        }
                      },
                    ),
                  
                  )
                ),
                )
              ],)
          ),
        ),
      );
  }
}

@override
void afterFirstLayout(BuildContext context) {
  // Calling the same function "after layout" to resolve the issue.
  afterAppLoaded();
}

///1. Load JSON data from api
Future<List<PreviousSearch>> previousSearchFuture = getPreviousSearches();

Future<List<PreviousSearch>> getPreviousSearches() async {
  List<PreviousSearch> myMap = await PreviousSearchesProvider().getData();
  return myMap;
}

Future<bool> deletePreviousSearch(convid) async {
  return await PreviousSearchesProvider().deleteSearch(convid);
}

Widget buildPreviousSearches(List<PreviousSearch> previousSearches, Future deleteIndividualSearch(string)) {
  return ListView.builder(
    itemCount: previousSearches.length,
    itemBuilder: (context, index) {
      final ps = previousSearches[index];
      SavedSearchCard _savedSearchCard = SavedSearchCard(cardSearch: ps);
      return GestureDetector(
        child: Dismissible(
          direction: DismissDirection.endToStart,
          key: Key(previousSearches[index].prompt),
          background: Container(
            color: Colors.red,
            child: Align(
              child: Padding(
                padding: const EdgeInsets.only(right: 26),
                child: Icon(Icons.delete),
              ),
              alignment: Alignment.centerRight,
            ),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              return false;
            } else {
              bool delete = true;
              final snackbarController = ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Deleting ${previousSearches[index].prompt}'),
                  action: SnackBarAction(label: 'Cancel', onPressed: () => delete = false),
                  duration: Duration(seconds: 1),
                ),
              );
              await snackbarController.closed;
              return delete;
            }
          },
          onDismissed: (_) {
            // PreviousSearchesProvider().deleteSearch(previousSearches[index].conv_id);
            deleteIndividualSearch(previousSearches[index].conv_id);
            previousSearches.removeAt(index);
          },
          child: _savedSearchCard.buildSearchCard(context),
        ),
        onTap: () {
          Globals.currentPreviousSearch = ps;
          Globals.currentHTMLPage = ps.page_url;
          Globals.currentShareHTMLPage = ps.share_url;
          if (Globals.lastPage == AppConstants.resultsRouteName) {
            context.push(
              context.namedLocation(AppConstants.resultsRouteName),
            );
          } else {
            context.pop();
          }
        },
      );
    },
  );
}

void afterAppLoaded() {
  Globals.printDebug(inText: "After App Loaded in Catgeories page");
}

void SetupOtherURIs() {
  Globals.printDebug(inText: 'PreviousSearchPage SetupOtherURIs started');
  GetUri _getUri4Previous = GetUri(AppConstants.previousSearchRef); // Setup and get sub categories
  GetUri _getUri4DeletePrevious = GetUri(AppConstants.deletePreviousSearchRef);
  GetUri _getUri4DeleteAllPrevious = GetUri(AppConstants.deleteAllSearches);
  Globals.previousSearchUri = _getUri4Previous.SetUri();
  Globals.printDebug(inText: 'AppStartUp previousSearchUri = ${Globals.previousSearchUri.path} started');
  Globals.deletePreviousSearchUri = _getUri4DeletePrevious.SetUri();
  Globals.deleteAllSearchesUri = _getUri4DeleteAllPrevious.SetUri();
}
