class SampleService {
  List<String> samples = [];

  void add(String sample) => samples.add(sample);

  void remove(String sample) => samples.removeAt(samples.indexOf(sample));
}
