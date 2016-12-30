export const  signup = (username, password) => {
  $.ajax({
    method: 'POST',
    url: '/api/users',
    data: {
      user: { username: username, password: password }
    },
    success: (res) => {
      console.log(res);
    },
    error: (err) => {
      console.log(err);
    }
  });
};

export const login = (username, password) => {
  $.ajax({
    method: 'POST',
    url: '/api/session',
    data: {
      user: { username: username, password: password }
    },
    success: (res) => {
      console.log(res);
    },
    error: (err) => {
      console.log(err);
    }
  });
};

export const logout = () => {
  $.ajax({
    method: 'DELETE',
    url: '/api/session',
    success: (res) => {
      console.log(res);
    },
    error: (err) => {
      console.log(err);
    }
  });
};
