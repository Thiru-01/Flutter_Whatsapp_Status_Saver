import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class PerimissionPage extends StatelessWidget {
  final Function askPermission;
  const PerimissionPage({Key? key, required this.askPermission})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: SvgPicture.asset(
              "assets/svg/2.svg",
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0.h),
            child: Text(
              "Allow permissions for accessing media",
              style: TextStyle(color: Colors.black26, fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0, minimumSize: Size(double.infinity, 6.h)),
                onPressed: () async {
                  askPermission();
                },
                child: const Text("Allow")),
          )
        ],
      ),
    );
  }
}
