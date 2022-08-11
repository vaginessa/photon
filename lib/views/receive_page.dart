import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../services/photon_client.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({Key? key}) : super(key: key);

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  _scan() async {
    return await PhotonClient.scan();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receive'),
      ),
      body: FutureBuilder(
        future: _scan(),
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (snap.data.length == 0) ...{
                    const Text('No device found')
                  } else ...{
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: snap.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {},
                            title: Text(snap.data[index]),
                          );
                        })
                  }
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (width < 720) ...{
                      const SizedBox(
                        height: 50,
                      ),
                    },
                    const Text(
                      'Scanning ...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Center(
                      child: Lottie.asset('assets/lottie/wifi_scan.json',
                          width: width < 720 ? 400 : width / 2.4,
                          height: width < 720 ? 400 : width / 2.4),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {});
        },
        child: const Text('Retry'),
      ),
    );
  }
}
