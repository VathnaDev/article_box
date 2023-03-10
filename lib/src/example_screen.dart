import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/api/clients/todo_api_client.dart';
import 'dev/dev_tool.dart';
import 'dev/model/dev_tool_item.dart';
import 'dev/widgets/dev_switch.dart';
import 'dev/widgets/dev_text_button.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  bool isSwitchEnable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          DevSwitch(
            label: "Animated Switch ${isSwitchEnable}",
            onTap: () {},
            onChange: (value) {
              // setState(() {
              //   isSwitchEnable = value;
              // });
            },
            isEnabled: isSwitchEnable,
          ),
          DevTextButton(
            title: "Dev Mode",
            onTap: () {
              showDialog(
                barrierColor: Colors.indigo,
                barrierDismissible: false,
                context: context,
                builder: (_) => DevTool(
                  onClose: () {
                    Navigator.of(context).pop();
                  },
                  onItemTap: (item) async {
                    Navigator.of(context).pop();

                    final todoService = context.read<TodoApiClient>();
                    final todos = await todoService.getTodos();
                  },
                  items: [
                    DevToolItem(
                      id: "http",
                      title: "http".toUpperCase(),
                    ),
                  ],
                ),
                useSafeArea: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
