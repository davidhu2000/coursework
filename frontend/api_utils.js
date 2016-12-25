const APIUtil = {
  followUser: id => (
    $.ajax({
      method: "post",
      url: `/users/${id}/follow/`,
      dataType: "json"
    })
  ),

  unfollowUser: id => (
    $.ajax({
      method: "delete",
      url: `/users/${id}/follow/`,
      dataType: "json"
    })
  ),

  searchUsers: (queryVal, success) => {
    $.ajax({
      method: 'get',
      url: '/users/search',
      dataType: 'json',
      data: { query: queryVal },
      success: res => {
        console.log('success');
        success(res);
      },
      error: err => {
        console.log('issues');
        console.log(err);
      }
    });
  }
};

module.exports = APIUtil;
