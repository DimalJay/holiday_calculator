List countryCodes = [
  {"name": "United Kindom", "code": "uk"},
  {"name": "United States", "code": "usa"},
  {"name": "Sri Lanka", "code": "lk"},
  {"name": "India", "code": "indian"},
  {"name": "Russian", "code": "russian"},
  {"name": "German", "code": "german"},
  {"name": "Ukrainian", "code": "ukrainian"},
]..sort(
    (a, b) => (a['name'] as String).compareTo(b['name'] as String),
  );
