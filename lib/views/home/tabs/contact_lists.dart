import 'package:emergency/common/custom_textfield.dart';
import 'package:emergency/common/reusable_text.dart';
import 'package:emergency/data/model/contact_model.dart';
import 'package:emergency/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';

class ContactLists extends StatefulWidget {
  const ContactLists({super.key});

  @override
  State<ContactLists> createState() => _ContactListsState();
}

class _ContactListsState extends State<ContactLists> {
  late Box<ContactModel> _contacts;

  @override
  void initState() {
    _contacts = Hive.box<ContactModel>('contactModel');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 30.h),
          children: [
            Gap(14.h),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 12.w,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color(0xfffae7af),
              ),
              height: 80.h,
              alignment: Alignment.center,
              child: const ReusableText(
                'Trusted Contacts',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(30.sp),
            if (_contacts.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _contacts.length,
                itemBuilder: (_, i) {
                  var contact = _contacts.getAt(i);
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 12.w),
                    child: ListTile(
                      title: ReusableText(
                        contact!.name,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      subtitle: ReusableText(
                        contact.mobileNum,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      // leading: Container(
                      //   height: 50.h,
                      //   width: 50.w,
                      //   margin: EdgeInsets.only(right: 13.w),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(30.h),
                      //     color: const Color(0xfff9e5ae),
                      //   ),
                      //   alignment: Alignment.center,
                      //   child: ReusableText(
                      //     '${i + 1}',
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      contentPadding: EdgeInsets.zero,
                      trailing: GestureDetector(
                        onTap: (){
                          setState(() {
                            _contacts.delete(contact.mobileNum);
                          });
                        },
                        child: Container(
                          width: 36.w,
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.red,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            if(_contacts.isEmpty)
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 12.w),
                height: MediaQuery.of(context).size.height - 184.h,
                alignment: Alignment.center,
                child: const ReusableText(
                  'No contact have been added yet',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  fontFamily: 'poppins',
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 53.sp,
        width: 53.sp,
        child: FloatingActionButton(
          onPressed: () {
            _showCustomDialog(context);
          },
          backgroundColor: const Color(0xfff9e5ae),
          child: Icon(
            Icons.add_ic_call_rounded,
            size: 19.sp,
          ),
          // shape: RoundedRectangleBorder(
          //   // borderRadius: BorderRadius.all(Radius.circular(50),),
          // ),
        ),
      ),
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          // title: Text(
          //   'Enter Details',
          //   style: TextStyle(color: Color(0xFF00BFA5)),
          // ),
          // contentPadding: EdgeInsets.zero,
          child: Builder(
            builder: (context) {
              // var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;
              final phoneNumber = TextEditingController();
              final name = TextEditingController();

              return Container(
                // height: height,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xfff9e5ae),
                    Color(0xffb1a99c),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                width: width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ReusableText(
                      'Enter Details',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                      fontSize: 22,
                    ),
                    Gap(6.h),
                    const Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    Gap(24.h),
                    const ReusableText(
                      'Phone Number',
                      // color: Colors.b,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                      fontSize: 16,
                    ),
                    Gap(10.h),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      height: 55.h,
                      hintText: 'e.g., 01722522279',
                      prefixIcon: Icon(
                        Icons.call_rounded,
                        size: 20.sp,
                        color: AppConstants.kBkDark,
                      ),
                      controller: phoneNumber,
                    ),
                    Gap(25.h),
                    const ReusableText(
                      'Name',
                      // color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                      fontSize: 16,
                    ),
                    Gap(10.h),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      height: 55.h,
                      hintText: 'e.g., Father',
                      prefixIcon: Icon(
                        Icons.person,
                        size: 20.sp,
                        color: AppConstants.kBkDark,
                      ),
                      controller: name,
                    ),
                    Gap(30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const ReusableText(
                            'Close',
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 14.5,
                            fontFamily: 'poppins',
                          ),
                        ),
                        Gap(18.w),
                        TextButton(
                          onPressed: () {
                            if (name.text.isNotEmpty &&
                                phoneNumber.text.isNotEmpty) {
                              if (isValidPhoneNumber(phoneNumber.text)) {
                                setState(() {
                                  _contacts.put(
                                    phoneNumber.text,
                                    ContactModel(
                                      mobileNum: phoneNumber.text,
                                      name: name.text,
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: ReusableText(
                                        'Number is added to the trusted list',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'poppins',
                                      ),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                });
                              } else {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: ReusableText(
                                      'Invalid format for phone number',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'poppins',
                                    ),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                Navigator.of(context).pop();
                              }
                            } else {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: ReusableText(
                                    'Fill the empty fields first',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'poppins',
                                  ),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          child: const ReusableText(
                            'Save',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00BF6D),
                            fontSize: 14.5,
                            fontFamily: 'poppins',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  bool isValidPhoneNumber(String input) {
    final phoneNumberRegex = RegExp(
        r'^\+?\d{1,3}[-.\s]?\(?\d{1,4}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,9}$');
    return phoneNumberRegex.hasMatch(input);
  }
}
