
List phoneNumberVariantsList({
  String? phoneNumber,
  String? countryCode,
}) {
  List list = [
    '+${countryCode!.substring(1)}$phoneNumber',
    '+${countryCode.substring(1)}-$phoneNumber',
    '${countryCode.substring(1)}-$phoneNumber',
    '${countryCode.substring(1)}$phoneNumber',
    '0${countryCode.substring(1)}$phoneNumber',
    '0$phoneNumber',
    '$phoneNumber',
    '+$phoneNumber',
    '+${countryCode.substring(1)}--$phoneNumber',
    '00$phoneNumber',
    '00${countryCode.substring(1)}$phoneNumber',
    '+${countryCode.substring(1)}-0$phoneNumber',
    '+${countryCode.substring(1)}0$phoneNumber',
    '${countryCode.substring(1)}0$phoneNumber',
  ];
  return list;
}
