import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/general_provider.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    actions: [
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/storeManager');
        },
        icon: const Icon(Icons.sd_card),
        tooltip: 'Manage Caching Stores',
      ),
      IconButton(
        onPressed: () {
          Provider.of<GeneralProvider>(context, listen: false)
              .currentMapCachingManager
              .deleteAllStores();
        },
        icon: const Icon(Icons.layers),
        tooltip: 'Manage Map Layers',
      ),
    ],
    leading: Tooltip(
      message: 'Enable/Disable Caching',
      child: Switch(
        onChanged: (bool newVal) async {
          final GeneralProvider provider =
              Provider.of<GeneralProvider>(context, listen: false);
          provider.cachingEnabled = newVal;
          provider.resetMap();
          if (newVal) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Caching to: ${provider.storeName}',
                ),
                action: SnackBarAction(
                  label: 'Stop Caching',
                  onPressed: () => provider.cachingEnabled = false,
                ),
              ),
            );
          }
        },
        value: Provider.of<GeneralProvider>(context).cachingEnabled,
      ),
    ),
    title: const Text('FMTC Demo'),
    elevation: 0,
  );
}
