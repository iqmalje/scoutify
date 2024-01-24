class Facility {
  late String facilityID,
      createdBy,
      handledBy,
      name,
      address1,
      address2,
      city,
      state,
      imageURL,
      pic;

  late int postcode;

  Facility(Map<String, dynamic> item) {
    facilityID = item['facility'];
    createdBy = item['created_by'];
    name = item['name'];
    address1 = item['address1'] ??= '';
    address2 = item['address2'] ??= '';
    city = item['city'];
    state = item['state'];
    imageURL = item['image_url'];
    pic = item['pic'] ??= 'None';
    postcode = item['postcode'];
  }
}
