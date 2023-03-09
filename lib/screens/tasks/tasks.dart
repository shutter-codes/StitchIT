import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:tailor_made/rebloc/app_state.dart';
import 'package:tailor_made/rebloc/jobs/view_model.dart';
import 'package:tailor_made/screens/tasks/_partials/task_list_item.dart';
import 'package:tailor_made/widgets/_partials/mk_app_bar.dart';
import 'package:tailor_made/widgets/_partials/mk_loading_spinner.dart';
import 'package:tailor_made/widgets/_views/empty_result_view.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MkAppBar(title: Text("Tasks")),
      body: ViewModelSubscriber<AppState, JobsViewModel>(
        converter: (store) => JobsViewModel(store),
        builder: (BuildContext context, _, JobsViewModel vm) {
          if (vm.isLoading) {
            return const MkLoadingSpinner();
          }
          final _tasks = vm.tasks;

          if (_tasks == null || _tasks.isEmpty) {
            return const Center(child: EmptyResultView(message: "No tasks available"));
          }

          return ListView.separated(
            itemCount: _tasks.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 96.0),
            itemBuilder: (_, index) => TaskListItem(task: _tasks[index]),
            separatorBuilder: (_, __) => const Divider(height: 0.0),
          );
        },
      ),
    );
  }
}
