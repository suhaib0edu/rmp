import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rmp/objectbox.g.dart'; // created by `flutter pub run build_runner build`
import 'package:rmp/index_c.dart';
export 'models.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "rmpDB"));
    return ObjectBox._create(store);
  }

  static void deleteDbFiles() async {
    getApplicationDocumentsDirectory().then((docDir) {
      final directory = Directory('${docDir.path}/rmpDB');
      directory.deleteSync(recursive: true);
    });
  }
}

Store store = objectBox.store;

final configDB = store.box<ConfigDB>();
final categorySL = store.box<CategorySL>();
final orderSL = store.box<OrdersSL>();
final productsOrderSL = store.box<ProductsOrderSL>();
final productsSL = store.box<ProductsSL>();