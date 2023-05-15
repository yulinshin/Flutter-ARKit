import 'dart:math' as math;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class HelloWorldPage extends StatefulWidget {
  @override
  _HelloWorldPagState createState() => _HelloWorldPagState();
}

class _HelloWorldPagState extends State<HelloWorldPage> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('ARKit in Flutter'),
      ),
      body: Container(
        child: ARKitSceneView(
          onARKitViewCreated: onARKitViewCreated,
          environmentTexturing:
          ARWorldTrackingConfigurationEnvironmentTexturing.automatic,
        ),
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.add(_createPlane());
    this.arkitController.add(_createText());
  }

  ARKitNode _createPlane() {
    final plane = ARKitPlane(
      width: 1,
      height: 1,
        materials: [
          ARKitMaterial(diffuse: ARKitMaterialImage(BoardTexture))
        ]
    );
    return ARKitNode(
      geometry: plane,
      position: vector.Vector3(0, 0, -2),
    );
  }

  ARKitNode _createText() {
    final text = ARKitText(
      text: 'AR SCENE',
      extrusionDepth: 1,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty.color(Colors.blue),
        )
      ],
    );
    return ARKitNode(
      geometry: text,
      position: vector.Vector3(-0.6, 0.6, -2),
      scale: vector.Vector3(0.02, 0.02, 0.02),
    );
  }
}
const BoardTexture = 'images/1.png';
