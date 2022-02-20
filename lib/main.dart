import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hobbies_client/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  final HttpLink link =  HttpLink("https://grap-test-app.herokuapp.com/graphql");
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore()))
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {

  final ValueNotifier<GraphQLClient> client;

  const MyApp({Key? key, required this.client}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     var theme = Theme.of(context).textTheme;
     return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: theme,
              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.black87),
                  textTheme: theme)),
          home: HomeScreen(),
        ),
      ),
    );
  }
}




