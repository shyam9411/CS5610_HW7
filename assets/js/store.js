import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze-strict';

let session0 = localStorage.getItem('session');
  if (session0) {
    session0 = JSON.parse(session0);
}

function session(st0 = null, action) {
    switch (action.type) {
        case 'LOG_IN_MANAGER':
        case 'LOG_IN_WORKER':
            return action.data;
        case 'LOG_OUT':
            return null;
        default:
            return st0;
    }
}


function managerLogin(st0 = {email: "", password: "", errors: null}, action) {
    switch(action.type) {
        case 'CHANGE_LOGIN':
            return Object.assign({}, st0, action.data);
        default:
            return st0;
    }
}

function workerLogin(st0 = {email: "", password: "", errors: null}, action) {
    switch(action.type) {
        case 'CHANGE_LOGIN':
            return Object.assign({}, st0, action.data);
        default:
            return st0;
    }
}

function jobsSheet(st0 = new Map(), action) {
    switch(action.type) {
        case 'JOBS_SHEET':
            let st1 =  new Map(st0)
            for (let job of action.data)
                st1.set(job.id, job);

            return st1;
        default:
            return st0;
    }
}

function newTask(st0 = {job_id: 1, hours: 0, description: "", worker_id: 0, status: false}, action) {
    switch(action.type) {
        case 'NEW_TASK':
            return Object.assign({}, st0, action.data);
        default:
            return st0;
    }
}

function tasksSheet(st0 = new Map(), action) {
    switch(action.type) {
        case 'TASKS_SHEET':
            let st1 =  new Map(st0)
            for (let task of action.data)
                st1.set(task.id, task);

            return st1;
        default:
            return st0;
    }
}

function forms(st0, action) {
    let reducer = combineReducers({
        managerLogin,
        workerLogin,
        jobsSheet,
        tasksSheet,
        newTask
    });
    return reducer(st0, action);
  }

function root_reducer(st0, action) {
    console.log("root reducer", st0, action);
    let reducer = combineReducers({
        session,
        forms
    });
    return deepFreeze(reducer(st0, action));
}
  
let store = createStore(root_reducer);
export default store;