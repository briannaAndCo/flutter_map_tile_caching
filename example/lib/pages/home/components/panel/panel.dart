import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:fmtc_example/pages/home/components/panel/stat_builder.dart';
import 'package:provider/provider.dart';
import '../../../../state/general_provider.dart';

class Panel extends StatelessWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Consumer<GeneralProvider>(
        builder: (context, provider, _) {
          final MapCachingManager mcm =
              MapCachingManager(provider.parentDirectory!, provider.storeName);

          return StreamBuilder<void>(
            stream: mcm.watchStoreChanges,
            builder: (context, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                statBuilder(
                  stat: mcm.storeLength.toString(),
                  description: 'Total Tiles',
                ),
                statBuilder(
                  stat: mcm.storeSize!.toStringAsFixed(2) + 'KiB',
                  description: 'Total Size',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
