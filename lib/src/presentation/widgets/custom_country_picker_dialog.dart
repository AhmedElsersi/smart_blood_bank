import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'default_text.dart';

class CustomCountryPickerDialog extends StatelessWidget {
  const CustomCountryPickerDialog({
    Key? key,
    required this.onCountryPicked,
  }) : super(key: key);

  final Function(Country country) onCountryPicked;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.pink,
      ),
      child: CountryPickerDialog(
        titlePadding: const EdgeInsets.all(8.0),
        searchCursorColor: Colors.pinkAccent,
        searchInputDecoration: InputDecoration(
          hintText: 'context.search',
        ),
        isSearchable: true,
        // itemFilter: (c) => ['SA', 'EG'].contains(c.isoCode),
        // priorityList: [
        //   CountryPickerUtils.getCountryByIsoCode('SA'),
        //   CountryPickerUtils.getCountryByIsoCode('EG'),
        // ],
        title: DefaultText(text: 'context.phoneCodeSelect'),
        onValuePicked: onCountryPicked,
        itemBuilder: (country) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              CountryPickerUtils.getFlagImageAssetPath(
                country.isoCode,
              ),
              height: 15.0,
              width: 25.0,
              fit: BoxFit.fill,
              package: "country_pickers",
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: DefaultText(
                overflow: TextOverflow.ellipsis,
                text: country.name,
                fontSize: 10.sp,
              ),
            ),
            const Spacer(),
            DefaultText(
              overflow: TextOverflow.ellipsis,
              text: "+${country.phoneCode}",
              fontSize: 10.sp,
            ),
          ],
        ),
      ),
    );
  }
}
