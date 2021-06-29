import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/home/models/job.dart';

class JobListTile extends StatelessWidget {
  const JobListTile({Key key, @required this.job, @required this.onTap})
      : super(key: key);
  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
