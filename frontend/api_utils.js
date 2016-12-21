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
  )
};

module.exports = APIUtil;
