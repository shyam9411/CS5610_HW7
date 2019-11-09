import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Switch, Route, NavLink, Link } from 'react-router-dom';
import { Navbar, Nav, Col } from 'react-bootstrap';
import ManagerLogin from './managerLogin';
import WorkerLogin from './WorkerLogin';
import { Provider, connect } from 'react-redux';
import WorkerView from './workerView';
import ManagerView from './ManagerView';

import { Redirect } from 'react-router';

import store from './store';

export default function init_page(root) {
    let tree = (
        <Provider store={store}>
            <Page />
        </Provider>
    );
    ReactDOM.render(tree, root);
}

function Page(props) {
    return (
      <Router>
        <Navbar bg="dark" variant="dark">
          <Col md="8">
            <Nav>
              <Nav.Item>
                <NavLink to="/" exact activeClassName="active" className="nav-link">
                  Home
                </NavLink>
              </Nav.Item>
            </Nav>
          </Col>
          <Col md="4">
            <Session />
          </Col>
        </Navbar>
  
        <Switch>
          <Route exact path="/">
            <h1>Home</h1>
          </Route>
  
          <Route exact path="/WorkerLogin">
            <WorkerLogin/>
          </Route>
  
          <Route exact path="/ManagerLogin">
            <ManagerLogin/>
          </Route>

          <Route exact path="/worker">
            <WorkerView/>
          </Route>

          <Route exact path="/manager">
            <ManagerView/>
          </Route>
        </Switch>
      </Router>
    );
  }
  
  let Session = connect(({session}) => ({session}))(({session, dispatch}) => {
    function logout(ev) {
      ev.preventDefault();
      localStorage.removeItem('session');
      dispatch({
        type: 'LOG_OUT',
      });
    }
  
    if (session) {
      return (
        <div>
          <Nav>
            <Nav.Item>
              <p className="text-light py-2">User: {session.user_name}</p>
            </Nav.Item>
            <Nav.Item>
              <NavLink to="/" exact activeClassName="active" className="nav-link">
                <a className="nav-link" href="#" onClick={logout}>Logout</a>
              </NavLink>
            </Nav.Item>
          </Nav>
          <Redirect to={session.worker ? "/worker" : "/manager"} />
        </div>
      );
    }
    else {
      return (
        <div>
          <Nav>
            <Nav.Item>
              <NavLink to="/WorkerLogin" exact activeClassName="active" className="nav-link">
                  Worker Login
              </NavLink>
            </Nav.Item>
            <Nav.Item>
              <NavLink to="/ManagerLogin" exact activeClassName="active" className="nav-link">
                  Manager Login
              </NavLink>
            </Nav.Item>
          </Nav>
          <Redirect to={"/"} />
        </div>
      );
    }
  });