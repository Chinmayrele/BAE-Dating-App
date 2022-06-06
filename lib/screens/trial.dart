import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Trail extends StatefulWidget {
  const Trail({Key? key}) : super(key: key);

  @override
  State<Trail> createState() => _TrailState();
}

class _TrailState extends State<Trail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.cyan,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 90),
          IntlPhoneField(
            dropdownTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            cursorColor: Colors.pink,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.dark,
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(
                    color: Colors.pink,
                    width: 2,
                  )),
              fillColor: Colors.white24,
              filled: true,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(
                    color: Colors.pink,
                    width: 2,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(
                    color: Colors.pink,
                    width: 2,
                  )),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              floatingLabelStyle: const TextStyle(
                  color: Colors.pink, fontWeight: FontWeight.normal),
              label: const Text('Phone Number'),
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 18),
              prefixIcon: const Icon(Icons.phone_forwarded_outlined,
                  color: Colors.white),
              // prefixText: '  +91 ',
              // prefixStyle: const TextStyle(
              //     fontSize: 20,
              //     color: Colors.white,
              //     fontWeight: FontWeight.bold),
            ),
            onChanged: (phone) {
              print(phone.completeNumber);
            },
            onCountryChanged: (country) {
              print('Country changed to: ' + country.name);
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      // Column(
      //   children: [
      //     const SizedBox(height: 150),
      //     Center(
      //       child: CountryCodePicker(
      //         onChanged: print,
      //         // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
      //         initialSelection: 'IT',
      //         favorite: const ['+39', 'FR'],
      //         // optional. Shows only country name and flag
      //         showCountryOnly: false,
      //         // optional. Shows only country name and flag when popup is closed.
      //         showOnlyCountryWhenClosed: false,
      //         // optional. aligns the flag and the Text left
      //         alignLeft: false,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
