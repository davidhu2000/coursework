const FollowToggle = require("./follow_toggle.js");
const UsersSearch = require("./user_search.js");

$(() => {
  $('.follow-toggle').each((index, el) => {
    let $el = $(el);
    const button = new FollowToggle($el);
  });

  let $search = $('#user-search');
  new UsersSearch($search);
});
