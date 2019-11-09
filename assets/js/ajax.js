import store from './store';

export function post(path, body) {
  let state = store.getState();
  let token = (state.session != null) ? state.session.token : "";

  return fetch('/ajax' + path, {
    method: 'post',
    credentials: 'same-origin',
    headers: new Headers({
      'x-csrf-token': window.csrf_token,
      'content-type': "application/json; charset=UTF-8",
      'accept': 'application/json',
      'x-auth': token || "",
    }),
    body: JSON.stringify(body),
  }).then((resp) => resp.json());
}

export function get(path) {
  let state = store.getState();
  let token = (state.session != null) ? state.session.token : "";

  return fetch('/ajax' + path, {
    method: 'get',
    credentials: 'same-origin',
    headers: new Headers({
      'x-csrf-token': window.csrf_token,
      'content-type': "application/json; charset=UTF-8",
      'accept': 'application/json',
      'x-auth': token || "",
    }),
  }).then((resp) => resp.json());
}

export function submit_manager_login(form) {
  let state = store.getState();
  let data = state.forms.managerLogin;

  post('/managersession', data)
    .then((resp) => {
      console.log(resp);
      if (resp.token) {
        localStorage.setItem('session', JSON.stringify(resp));
        store.dispatch({
          type: 'LOG_IN_MANAGER',
          data: resp,
        });
        form.redirect('/');
      }
      else {
        store.dispatch({
          type: 'CHANGE_LOGIN',
          data: {errors: JSON.stringify(resp.errors)},
        });
      }
    });
}

export function submit_worker_login(form) {
  let state = store.getState();
  let data = state.forms.workerLogin;

  post('/workersession', data)
    .then((resp) => {
      console.log(resp);
      if (resp.token) {
        localStorage.setItem('session', JSON.stringify(resp));
        store.dispatch({
          type: 'LOG_IN_WORKER',
          data: resp,
        });
        form.redirect('/');
      }
      else {
        store.dispatch({
          type: 'CHANGE_LOGIN',
          data: {errors: JSON.stringify(resp.errors)},
        });
      }
    });
}

export function get_tasks_sheet() {
  get('/tasksindex')
    .then((resp) => {
      console.log(resp);
      localStorage.setItem('taskssheet', JSON.stringify(resp));
      store.dispatch({
        type: 'TASKS_SHEET',
        data: resp.data,
      });
  });
}

export function get_all_jobs() {
  get('/jobsindex')
    .then((resp) => {
      console.log(resp);
      localStorage.setItem('jobsindex', JSON.stringify(resp));
      store.dispatch({
        type: 'JOBS_SHEET',
        data: resp.data,
      });
  });
}

export function submit_task(data) {
  console.log(data);
  post('/newTask', data)
  .then((resp) => {
    console.log(resp);
    localStorage.setItem('newTask', JSON.stringify(resp));
      store.dispatch({
        type: 'NEW_TASK',
        data: resp.data,
      });
  });
}

export function update_task(data) {
  console.log(data);
  post('/updateTask', data)
  .then((resp) => {
    console.log(resp);
    localStorage.setItem('updateTask', JSON.stringify(resp));
      store.dispatch({
        type: 'TASKS_SHEET',
        data: resp.data,
      });
  });
}