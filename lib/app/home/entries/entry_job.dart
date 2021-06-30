import 'package:flutter_time_tracker/app/home/models/job.dart';
import 'package:flutter_time_tracker/app/home/models/entry.dart';

class EntryJob {
  EntryJob(this.entry, this.job);

  final Entry entry;
  final Job job;
}
