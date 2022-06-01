import 'package:bar_chat_dating_app/providers/info_provider.dart';
import 'package:bar_chat_dating_app/screens/home_page_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_tinder_clone_app/models/user_info.dart';

import '../models/user_info.dart';
import 'location_permi.dart';

class UserInfoForm extends StatefulWidget {
  const UserInfoForm({Key? key}) : super(key: key);

  @override
  State<UserInfoForm> createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  late InfoProviders profileUserInfo;
  final _form = GlobalKey<FormState>();
  String? _selectedGender;
  String? _selectedAge;

  List<String> items = [
    'Male',
    'Female',
    'Other',
  ];
  List<String> ages = [
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
  ];

  var _editedProfile = UserInfo(
    name: '',
    email: '',
    phoneNo: '',
    gender: '',
    age: 0,
    about: '',
    interest: '',
    address: '',
  );

  titleText(String text, bool isRequired) {
    return Container(
      margin: const EdgeInsets.only(left: 25, bottom: 8, top: 15),
      child: RichText(
          text: TextSpan(
              text: text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              children: [
            if (isRequired)
              const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
          ])),
    );
  }

  void saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    print(
        "USER AGE ${_editedProfile.age}\nUSER GENDER ${_editedProfile.gender}\nUSER NAME ${_editedProfile.name}");
    //Firebase Logic
    profileUserInfo.addUserProfileInfo(_editedProfile);
    //Navigate after Completeing Firebase Logic
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const HomePageScreen()));
  }

  @override
  Widget build(BuildContext context) {
    profileUserInfo = Provider.of<InfoProviders>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.86,
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            titleText('Full Name', true),
            TextFormField(
              style: const TextStyle(color: Colors.white, fontSize: 16),
              cursorHeight: 22,
              cursorColor: Colors.pink,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.only(left: 25),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink, width: 2),
                    borderRadius: BorderRadius.circular(30)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: 'Name',
                hintStyle: const TextStyle(
                    color: Colors.white, fontSize: 15, wordSpacing: 2),
                fillColor: Colors.white24,
                filled: true,
                // suffixIcon: const Icon(Icons.mic, color: Colors.grey),
              ),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please Enter Your Name';
                }
                return null;
              },
              onSaved: (val) {
                _editedProfile = UserInfo(
                  name: val.toString(),
                  email: _editedProfile.email,
                  phoneNo: _editedProfile.phoneNo,
                  gender: _editedProfile.gender,
                  age: _editedProfile.age,
                  about: _editedProfile.about,
                  interest: _editedProfile.interest,
                  address: _editedProfile.address,
                );
              },
            ),
            titleText('Email', true),
            TextFormField(
              style: const TextStyle(color: Colors.white, fontSize: 16),
              // controller: _mySearched,
              cursorHeight: 22,
              // autofocus: true,
              cursorColor: Colors.pink,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.only(left: 25),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink, width: 2),
                    borderRadius: BorderRadius.circular(30)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: 'Email',
                hintStyle: const TextStyle(
                    color: Colors.white, fontSize: 15, wordSpacing: 2),
                fillColor: Colors.white24,
                filled: true,
                suffixIcon:
                    const Icon(Icons.email_outlined, color: Colors.grey),
              ),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please Enter your Email id';
                } else if (!val.contains('@') &&
                    !val.contains('.') &&
                    val.length < 10) {
                  return 'Please Enter a Valid Email id';
                }
                return null;
              },
              onSaved: (val) {
                _editedProfile = UserInfo(
                  name: _editedProfile.name,
                  email: val.toString(),
                  phoneNo: _editedProfile.phoneNo,
                  gender: _editedProfile.gender,
                  age: _editedProfile.age,
                  about: _editedProfile.about,
                  interest: _editedProfile.interest,
                  address: _editedProfile.address,
                );
              },
            ),
            titleText('Phone Number', true),
            TextFormField(
              autovalidateMode: AutovalidateMode.disabled,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              // controller: _mySearched,
              cursorHeight: 22,
              // autofocus: true,
              cursorColor: Colors.pink,
              keyboardType: TextInputType.number,
              keyboardAppearance: Brightness.dark,
              maxLength: 10,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.only(left: 25),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink, width: 2),
                    borderRadius: BorderRadius.circular(30)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: 'Phone Number',
                hintStyle: const TextStyle(
                    color: Colors.white, fontSize: 15, wordSpacing: 2),
                fillColor: Colors.white24,
                filled: true,
                suffixIcon: const Icon(Icons.phone, color: Colors.grey),
              ),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please Enter a Your Mobile No.';
                } else if (val.length != 10) {
                  return 'Please Enter a Valid Mobile Number';
                }
                return null;
              },
              onSaved: (val) {
                _editedProfile = UserInfo(
                  name: _editedProfile.name,
                  email: _editedProfile.email,
                  phoneNo: val.toString(),
                  gender: _editedProfile.gender,
                  age: _editedProfile.age,
                  about: _editedProfile.about,
                  interest: _editedProfile.interest,
                  address: _editedProfile.address,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText('Gender', true),
                    SizedBox(
                      width: 150,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: const [
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'Gender',
                                  style: TextStyle(
                                    fontSize: 15,
                                    wordSpacing: 2,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value as String;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down,
                          ),
                          iconSize: 24,
                          iconEnabledColor: Colors.grey,
                          iconDisabledColor: Colors.white24,
                          buttonHeight: 48,
                          buttonWidth: 150,
                          buttonPadding:
                              const EdgeInsets.only(left: 24, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.pink, width: 2),
                            color: Colors.white24,
                          ),
                          buttonElevation: 2,
                          itemHeight: 40,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          dropdownMaxHeight: 200,
                          dropdownWidth: 150,
                          dropdownPadding: const EdgeInsets.only(left: 24),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.pink,
                          ),
                          dropdownElevation: 8,
                          scrollbarRadius: const Radius.circular(30),
                          scrollbarThickness: 6,
                          scrollbarAlwaysShow: true,
                          offset: const Offset(0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText('Age', true),
                    SizedBox(
                      width: 160,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: const [
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'Age',
                                  style: TextStyle(
                                    fontSize: 15,
                                    wordSpacing: 2,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: ages
                              .map((age) => DropdownMenuItem<String>(
                                    value: age,
                                    child: Text(
                                      age,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: _selectedAge,
                          onChanged: (val) {
                            setState(() {
                              _selectedAge = val as String;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down,
                          ),
                          iconSize: 24,
                          iconEnabledColor: Colors.grey,
                          iconDisabledColor: Colors.white24,
                          buttonHeight: 48,
                          buttonWidth: 160,
                          buttonPadding:
                              const EdgeInsets.only(left: 24, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.pink, width: 2),
                            color: Colors.white24,
                          ),
                          buttonElevation: 2,
                          itemHeight: 40,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          dropdownMaxHeight: 140,
                          dropdownWidth: 150,
                          dropdownPadding: const EdgeInsets.only(left: 24),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.pink,
                          ),
                          dropdownElevation: 8,
                          scrollbarRadius: const Radius.circular(30),
                          scrollbarThickness: 6,
                          scrollbarAlwaysShow: true,
                          offset: const Offset(0, 0),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         titleText('Gender', true),
            //         SizedBox(
            //           width: 150,
            //           child: TextFormField(
            //             style:
            //                 const TextStyle(color: Colors.white, fontSize: 16),
            //             // controller: _mySearched,
            //             cursorHeight: 22,
            //             // autofocus: true,
            //             cursorColor: Colors.pink,
            //             decoration: InputDecoration(
            //               enabledBorder: OutlineInputBorder(
            //                 borderSide:
            //                     const BorderSide(color: Colors.pink, width: 2),
            //                 borderRadius: BorderRadius.circular(30),
            //               ),
            //               contentPadding: const EdgeInsets.only(left: 25),
            //               focusedBorder: OutlineInputBorder(
            //                   borderSide: const BorderSide(
            //                       color: Colors.pink, width: 2),
            //                   borderRadius: BorderRadius.circular(30)),
            //               floatingLabelBehavior: FloatingLabelBehavior.never,
            //               hintText: 'Gender',
            //               hintStyle: const TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 15,
            //                   wordSpacing: 2),
            //               fillColor: Colors.white24,
            //               filled: true,
            //               suffixIcon: const Icon(Icons.arrow_drop_down,
            //                   color: Colors.grey),
            //             ),
            //             validator: (val) {
            //               if (val!.isEmpty) {
            //                 return 'Please Enter Your Gender';
            //               }
            //               return null;
            //             },
            //             onSaved: (val) {
            //               _editedProfile = UserInfo(
            //                 name: _editedProfile.name,
            //                 email: _editedProfile.email,
            //                 phoneNo: _editedProfile.phoneNo,
            //                 gender: val.toString(),
            //                 age: _editedProfile.age,
            //                 about: _editedProfile.about,
            //                 interest: _editedProfile.interest,
            //                 address: _editedProfile.address,
            //               );
            //             },
            //           ),
            //         ),
            //       ],
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         titleText('Age', true),
            //         SizedBox(
            //           width: 160,
            //           child: TextFormField(
            //             style:
            //                 const TextStyle(color: Colors.white, fontSize: 16),
            //             // controller: _mySearched,
            //             cursorHeight: 22,
            //             // autofocus: true,
            //             cursorColor: Colors.pink,
            //             decoration: InputDecoration(
            //               enabledBorder: OutlineInputBorder(
            //                 borderSide:
            //                     const BorderSide(color: Colors.pink, width: 2),
            //                 borderRadius: BorderRadius.circular(30),
            //               ),
            //               contentPadding: const EdgeInsets.only(left: 25),
            //               focusedBorder: OutlineInputBorder(
            //                   borderSide: const BorderSide(
            //                       color: Colors.pink, width: 2),
            //                   borderRadius: BorderRadius.circular(30)),
            //               floatingLabelBehavior: FloatingLabelBehavior.never,
            //               hintText: 'Age',
            //               hintStyle: const TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 15,
            //                   wordSpacing: 2),
            //               fillColor: Colors.white24,
            //               filled: true,
            //               suffixIcon: const Icon(Icons.arrow_drop_down,
            //                   color: Colors.grey),
            //             ),
            //             validator: (val) {
            //               if (val!.isEmpty) {
            //                 return 'Please Enter Your Age';
            //               } else if (int.tryParse(val) == null) {
            //                 return 'Please Enter a Valid Number';
            //               } else if (int.parse(val) <= 0) {
            //                 return 'Please Enter a Valid Age';
            //               }
            //               return null;
            //             },
            //             onSaved: (val) {
            //               _editedProfile = UserInfo(
            //                 name: _editedProfile.name,
            //                 email: _editedProfile.email,
            //                 phoneNo: _editedProfile.phoneNo,
            //                 gender: _editedProfile.gender,
            //                 age: int.parse(val.toString()),
            //                 about: _editedProfile.about,
            //                 interest: _editedProfile.interest,
            //                 address: _editedProfile.address,
            //               );
            //             },
            //           ),
            //         ),
            //       ],
            //     )
            //   ],
            // ),
            titleText('About', false),
            TextFormField(
              maxLines: null,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              // controller: _mySearched,
              cursorHeight: 22,
              // autofocus: true,
              cursorColor: Colors.pink,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.only(
                    left: 25, top: 6, bottom: 6, right: 15),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink, width: 2),
                    borderRadius: BorderRadius.circular(30)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: 'About',
                hintStyle: const TextStyle(
                    color: Colors.white, fontSize: 15, wordSpacing: 2),
                fillColor: Colors.white24,
                filled: true,
                // suffixIcon: const Icon(Icons.mic, color: Colors.grey),
              ),
              onSaved: (val) {
                _editedProfile = UserInfo(
                  name: _editedProfile.name,
                  email: _editedProfile.email,
                  phoneNo: _editedProfile.phoneNo,
                  gender: _editedProfile.gender,
                  age: _editedProfile.age,
                  about: val.toString(),
                  interest: _editedProfile.interest,
                  address: _editedProfile.address,
                );
              },
            ),
            titleText('Interest', true),
            TextFormField(
              maxLines: null,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              // controller: _mySearched,
              cursorHeight: 22,
              // autofocus: true,
              cursorColor: Colors.pink,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.only(left: 25),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink, width: 2),
                    borderRadius: BorderRadius.circular(30)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: 'Interest',
                hintStyle: const TextStyle(
                    color: Colors.white, fontSize: 15, wordSpacing: 2),
                fillColor: Colors.white24,
                filled: true,
                suffixIcon: const Icon(Icons.edit, color: Colors.grey),
              ),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please Enter Your Interests';
                }
                return null;
              },
              onSaved: (val) {
                _editedProfile = UserInfo(
                  name: _editedProfile.name,
                  email: _editedProfile.email,
                  phoneNo: _editedProfile.phoneNo,
                  gender: _editedProfile.gender,
                  age: _editedProfile.age,
                  about: _editedProfile.about,
                  interest: val.toString(),
                  address: _editedProfile.address,
                );
              },
            ),
            titleText('City', false),
            TextFormField(
              style: const TextStyle(color: Colors.white, fontSize: 16),
              // controller: _mySearched,
              cursorHeight: 22,
              // autofocus: true,
              cursorColor: Colors.pink,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.only(left: 25),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink, width: 2),
                    borderRadius: BorderRadius.circular(30)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: 'City',
                hintStyle: const TextStyle(
                    color: Colors.white, fontSize: 15, wordSpacing: 2),
                fillColor: Colors.white24,
                filled: true,
                suffixIcon: const Icon(Icons.location_on, color: Colors.grey),
              ),
              onSaved: (val) {
                _editedProfile = UserInfo(
                  name: _editedProfile.name,
                  email: _editedProfile.email,
                  phoneNo: _editedProfile.phoneNo,
                  gender: _editedProfile.gender,
                  age: _editedProfile.age,
                  about: _editedProfile.about,
                  interest: _editedProfile.interest,
                  address: val.toString(),
                );
              },
            ),
            const SizedBox(height: 8),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: ElevatedButton(
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                onPressed: () {
                  _editedProfile = UserInfo(
                    name: _editedProfile.name,
                    email: _editedProfile.email,
                    phoneNo: _editedProfile.phoneNo,
                    gender: _selectedGender.toString(),
                    age: int.parse(_selectedAge.toString()),
                    about: _editedProfile.about,
                    interest: _editedProfile.interest,
                    address: _editedProfile.address,
                  );
                  saveForm();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  primary: Colors.pink,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
