import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:fakrny/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payLoad}) : super(key: key);

  final String payLoad;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  String _payLoad = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _payLoad = widget.payLoad;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back_ios_rounded,
          ),
          splashRadius: 24.0,
          onPressed: () => Get.back(),
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          _payLoad.toString().split('|')[0],
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'Hello, Mohamed',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'You have new reminder',
                    style: Theme.of(context).textTheme.headline2,

                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: primaryClr,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.text_format,
                              color: white,
                              size: 24,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'Title',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _payLoad.toString().split('|')[0],
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.description,
                              color: white,
                              size: 24,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'Description',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _payLoad.toString().split('|')[1],
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              color: white,
                              size: 24,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'Date',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _payLoad.toString().split('|')[2],
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
