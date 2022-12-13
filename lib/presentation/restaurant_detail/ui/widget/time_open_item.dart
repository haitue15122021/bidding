import 'package:flutter/material.dart';
import '../../../../utils/device_utils.dart';
import '../../../../core/core.dart';

class TimeOpenItem extends StatelessWidget {
  final String timeOpen;

  const TimeOpenItem({this.timeOpen});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildRow(),
            ),
            const Divider(height: 0.5, color: appDividerColor)
          ],
        ));
  }

  Widget _buildRow() {
    var timeOpenParts = timeOpen.split('**');
    var dayOfWeekPart = timeOpenParts[0];
    var timePart = timeOpenParts[1];
    var openFrom = timePart.split('-')[0].trim();
    var openTo = timePart.split('-')[1].trim();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width:DeviceUtils.isMobile? 45:60,
            child: Text(
              dayOfWeekPart,
            )),
        Row(
          children: [
            SizedBox(
                width:DeviceUtils.isMobile? 85:105,
                child: Text(
                  openFrom,
                )),
            Text(
              ' - $openTo',
            ),
          ],
        )
      ],
    );
  }
}
