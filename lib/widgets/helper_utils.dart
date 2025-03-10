final List<Map<String, dynamic>> statusOptions = [
  {'value': 1, 'label': 'Available', 'color': "#279B0A"},
  {'value': 2, 'label': 'Checked-in', 'color': "#E96D3A"},
  {'value': 3, 'label': 'Reserved', 'color': "#DAA520"},
  {'value': 4, 'label': 'Under Maintenance', 'color': "#F62947"},
  {'value': 5, 'label': 'Dirty', 'color': "#FFF679"},
  {'value': 1, 'label': 'Checked-out', 'color': "#279B0A"},
];

String? getStatusColor({int? value, String? label}) {
  if (value == null && label == null) return null;

  for (var status in statusOptions) {
    if ((value != null && status['value'] == value) ||
        (label != null && status['label'] == label)) {
      return status['color'];
    }
  }

  return null; // Return null if no match is found
}
