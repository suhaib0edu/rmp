import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rmp/index_c.dart';
import 'package:rmp/pages/auth/auth_page.dart';
import 'package:rmp/services/utils.dart';
import 'widgets/w_items/index_w_items.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RMP',
      locale: const Locale('ar', 'SA'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: SuhColors.background,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      // home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuhColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            TopTaps(),
            ListOrderContainer(),
            ItemListOrderContainer(),
            ContainerTextWithIcon(),
            BottomTaps(),
          ],
        ),
      ),
    );
  }
}

Future<void> initAppDependencies() async {
  await initHiveForFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  objectBox = await ObjectBox.create();
  try{
    configDB.getAll().isEmpty?configDB.put(ConfigDB()):null;
  }catch (e){
    suhErrorIN('initAppDependencies()', e);
  }
}



