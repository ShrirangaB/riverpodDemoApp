import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_demo/data_model.dart';
import 'package:riverpod_demo/providers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Data> colorBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorBox = Hive.box('infoBox');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Hive.box('infoBox').close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiverPod Demo'),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconColorSizeConsumer(colorBox),
          ],
        ),
      ),
    );
  }
}

class IconColorSizeConsumer extends ConsumerWidget {
  final Box<Data> box;
  const IconColorSizeConsumer(this.box, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int iSize = ref.watch(iconSizeProvider).sizes;
    Color iColor = ref.watch(iconSizeProvider).newColor;

    if (box.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(iconSizeProvider.notifier).fromLocal(
            Color(int.parse((box.get(box.keys.last)?.color)!)),
            box.get(box.keys.last)?.size);
        iSize = ref.watch(iconSizeProvider).sizes;
        iColor = ref.watch(iconSizeProvider).newColor;
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.headset,
              size: iSize.toDouble() / 2,
              color: iColor,
            ),
            Icon(
              Icons.headset,
              size: iSize.toDouble(),
              color: iColor,
            ),
            Icon(
              Icons.headset,
              size: iSize.toDouble() / 2,
              color: iColor,
            ),
          ],
        ),
        Consumer(builder: (context, ref, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  coloredButton(ref, Colors.red, 'Red'),
                  coloredButton(ref, Colors.blue, 'Blue'),
                  coloredButton(ref, Colors.green, 'Green'),
                ],
              ),
              const SizedBox(
                height: 05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  coloredButton(ref, Colors.orange, 'Orange'),
                  coloredButton(ref, Colors.indigo, 'Indigo'),
                  coloredButton(ref, Colors.brown, 'Brown'),
                ],
              )
            ],
          );
        }),
        Consumer(
          builder: (context, ref, child) {
            return SizedBox(
              width: 500,
              child: Slider(
                value: iSize.toDouble(),
                max: 300,
                onChanged: (value) {
                  box.clear();
                  ref.read(iconSizeProvider.notifier).minMaxSize((value));
                },
              ),
            );
          },
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.lime,
            ),
            onPressed: () {
              final newData = Data(color: iColor.value.toString(), size: iSize);
              box.add(newData);
            },
            child: const Text('Add')),
        const SizedBox(height: 10),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () {
              box.clear();
            },
            child: const Text('clear')),
      ],
    );
  }

  ElevatedButton coloredButton(WidgetRef ref, Color color, String colorName) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        fixedSize: const Size(5, 5),
        shape: const CircleBorder(),
      ),
      onPressed: () {
        box.clear();
        ref.read(iconSizeProvider.notifier).colorIcon(colorName);
      },
      child: const Text(''),
    );
  }
}
