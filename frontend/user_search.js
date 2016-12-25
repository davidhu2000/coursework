const API = require('./api_utils.js');
const FollowToggle = require('./follow_toggle.js');

const UsersSearch = function ($el) {
    this.$el = $el;
    this.input = $el.find("input");
    this.ul = $el.find("ul");
    this.handleInput();
};

UsersSearch.prototype.handleInput = function () {
  this.$el.on('keyup', (e) => {
    e.preventDefault();
    let query = this.input.val();
    console.log('searching');
    console.log(query);
    API.searchUsers(query, this.updateList);
  });
};

UsersSearch.prototype.updateList = function (users) {
  $("nav ul").empty();
  console.log('list');
  console.log(users);
  users.forEach( user => {
    $("nav ul").append(`<li>
      <a href='/users/${user.id}'>${user.username}</a>
      <button id="follow-button-${user.id}" type="button" class="follow-toggle" name=""
       data-user-id="${user.id}"
       data-initial-follow-state="${user.followed}">
      </button>
    </li>`);

    new FollowToggle($(`#follow-button-${user.id}`));
  });
};

module.exports = UsersSearch;
