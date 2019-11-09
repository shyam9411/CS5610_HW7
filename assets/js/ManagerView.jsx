import React from 'react';

import { connect } from 'react-redux';
import { Alert } from 'react-bootstrap';

import { get_tasks_sheet, submit_task } from './ajax';

function state2props(state) {
  return {data: state.forms.tasksSheet};
}

class ManagerView extends React.Component {
  constructor (props) {
    super(props);

    this.tasks = null;
    get_tasks_sheet()
  }

  handleApproval(taskId) {
    let task = null;
    for (let [key, value] of this.tasks) {
      if (value.id == taskId) {
        task = value;
        break;
      }
    }

    task = Object.assign({}, task, {status: true})
    this.props.dispatch({
      type: 'NEW_TASK',
      data: task,
    });
    submit_task();
  }

  render() {
    let {data, dispatch} = this.props;
    this.tasks = data;
    let error_msg = null;
    if (data != null && data.size > 8) {
      error_msg = <Alert variant="danger">{ errors }</Alert>;
    }

    let dataRow = [];
    if (data != null) {
      for (const [key, value] of data.entries())
        dataRow.push(<tr>
          <td>{value.id}</td>
          <td>{value.hours}</td>
          <td>{value.description}</td>
          <td>{(value.status) ? <div className="text-success">Approved</div> : <a href="#" onClick={() => this.handleApproval(value.id)}>Approve request</a>}</td>
        </tr>)
    }

    return (
      <div>
        <h1>My Timesheet</h1>
        { error_msg }
        <table className="table table-striped table-bordered table-hover table">
            <thead>
                <tr>
                    <th>ID</th>
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
      </div>
    );
  }
}

export default connect(state2props)(ManagerView);