import React from 'react';

import { connect } from 'react-redux';
import { Alert } from 'react-bootstrap';

import { get_tasks_sheet } from './ajax';
import TaskView from './TaskView';

function state2props(state) {
  return {data: state.forms.tasksSheet};
}

class WorkerView extends React.Component {
  constructor (props) {
    super(props);
    this.state = {
      taskView: false
    }

    this.createNewTask = this.createNewTask.bind(this);
    get_tasks_sheet()
  }

  createNewTask() {
    this.setState({taskView: true});
  }

  render() {
    let {data, dispatch} = this.props;
    let error_msg = null;
    if (data != null && data.size > 8) {
      error_msg = <Alert variant="danger">{ errors }</Alert>;
    }

    if (this.state.taskView)
      return <TaskView/>;

    let dataRow = [];
    if (data != null) {
      for (const [key, value] of data.entries())
        dataRow.push(
        <tr>
          <td>{value.id}</td>
          <td>{value.hours}</td>
          <td>{value.description}</td>
          <td>{(value.status) ? <div className="text-success">Approved</div> : <div>Pending</div>}</td>
        </tr>)
    }

    return (
      <div>
        <h1>My Timesheet</h1>
        { error_msg }
        <table className="table table-striped table-bordered table-hover table">
            <thead>
                <tr>
                    <th>Job Code</th>
                    <th>Hours</th>
                    <th>Description</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                {
                  data != null ? dataRow : null
                }
            </tbody>
        </table>
        <div className="btn btn-primary" onClick={this.createNewTask}>Create a Task</div>
      </div>
    );
  }
}

export default connect(state2props)(WorkerView);