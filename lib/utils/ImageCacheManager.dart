import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImageCacheManager extends BaseCacheManager {
  static const key = "libCachedImageData";

  static ImageCacheManager _instance;

  factory ImageCacheManager() {
    if (_instance == null) {
      _instance = new ImageCacheManager._();
    }
    return _instance;
  }

  ImageCacheManager._() : super(key);

  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return p.join(directory.path, key);
  }
}
