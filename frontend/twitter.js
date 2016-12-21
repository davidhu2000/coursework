const FollowToggle = require("./follow_toggle.js");

$(() => {
  $('.follow-toggle').each((index, el) => {
    let $el = $(el);
    const button = new FollowToggle($el);

  });
});
