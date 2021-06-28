import 'package:flutter/foundation.dart';
import 'package:flutter_time_tracker/services/api_path.dart';
import 'package:flutter_time_tracker/app/home/models/job.dart';
import 'package:flutter_time_tracker/services/firestore_service.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FireStoreService.instance;

  Future<void> createJob(Job job) => _service.setData(
        path: APIPath.job(uid, 'job_abc'),
        data: job.toMap(),
      );

  Stream<List<Job>> jobsStream() => _service.collenctionStream(
        path: APIPath.jobs(uid),
        builder: (data) => Job.fromMap(data),
      );
}
