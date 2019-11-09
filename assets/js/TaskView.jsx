import React from 'react';

import { connect } from 'react-redux';
import { Form, Button, Alert } from 'react-bootstrap';

import { submit_task, get_all_jobs } from './ajax';

function state2props(state) {
  return {data: state.forms.newTask, jobs: state.forms.jobsSheet};
}

class TaskView extends React.Component {
  constructor (props) {
    super(props);
    this.state = {
        errorFound: false
    }

    this.jobs = null
    this.createTask = this.createTask.bind(this);
    get_all_jobs();
  }

  jobCodeOptions(jobs) {
      console.log(jobs);
      let options = ["Select a Job Code"];
      for (let [key, value] of jobs.entries()) {
          options.push(value.code);
      }

      return options.map(op => <option>{op}</option>);
  }

  changed(data) {
      console.log(data);
    this.props.dispatch({
      type: 'NEW_TASK',
      data: data,
    });
  }

  createTask(data) {
      console.log(data)
        for (let [key, value] of this.jobs)
            if (value.code == data.job_id) {
                data = Object.assign({}, data, {job_id: value.id})
                break;
            }
        
        
        if (data.hours < 9 && data.hours > 0)
            submit_task(this);
        else
            this.setState({errorFound: true})
  }

  render() {
      let {data, jobs, dispatch} = this.props;
      this.jobs = jobs;
      let errors = null;

      if (this.state.errorFound) {
          errors = <Alert variant="danger">{ errors }</Alert>;
      }

      return (
          <div>
              {errors}
              <h1>Create New Task</h1>
              <br></br>
                <Form.Group controlId="jobCode">
                    <Form.Label>Job Code</Form.Label>
                    <Form.Control as="select" onChange={
                        (ev) => this.changed({job_id: ev.target.value})}>
                            {this.jobCodeOptions(jobs)}
                    </Form.Control>
                </Form.Group>
                <Form.Group controlId="hours">
                    <Form.Label>Hours Spent</Form.Label>
                    <Form.Control type="text" onChange={
                        (ev) => this.changed({hours: ev.target.value})} />
                </Form.Group>
                <Form.Group controlId="Description">
                    <Form.Label>Description</Form.Label>
                    <Form.Control type="text" onChange={
                        (ev) => this.changed({description: ev.target.value})} />
                </Form.Group>
                <Form.Group controlId="submit">
                    <Button variant="primary" onClick={() => this.createTask(data)}>
                        Submit Task
                    </Button>
                </Form.Group>
          </div>
      );
  }
}

export default connect(state2props)(TaskView);