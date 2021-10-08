import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

Widget widthSpace(double widthSpace) {
  return SizedBox(
    width: widthSpace,
  );
}

Widget heightSpace(double heightSpace) {
  return SizedBox(
    height: heightSpace,
  );
}

String formatTimeStamp(Timestamp timestamp) {
  var dt = timestamp.toDate().toUtc();
  return dt.day.toString().trim() +
      "/" +
      dt.month.toString().trim() +
      "/" +
      dt.year.toString().trim();
}

FormFieldValidator<String>? requiredValidator() {
  FormFieldValidator<String>? validator = (value) {
    if (value == null || value.isEmpty) {
      return tr('this_field_is_required');
    }
    return null;
  };

  return validator;
}

FormFieldValidator<String>? requiredIntValidator() {
  FormFieldValidator<String>? validator = (value) {
    if (value == null || value.isEmpty) {
      return tr('this_field_is_required');
    }
    if (!isNumeric(value.trim())) return tr('must_be_number');
    return null;
  };

  return validator;
}

bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

String notNullString(any) {
  return any == null ? '' : any.toString();
}
