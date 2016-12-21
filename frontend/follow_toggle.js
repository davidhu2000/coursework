const API = require("./api_utils.js");

const FollowToggle = function($el) {
  this.$el = $el;
  this.userId = $el.data("user-id");
  this.initialFollowState = $el.data("initial-follow-state");
  this.followState = this.initialFollowState === true ? "followed" : "unfollowed";
  this.render();
  this.handleClick();
};

FollowToggle.prototype.render = function () {
  if (this.followState === 'followed') {
    this.$el.text('Unfollow!');
  } else {
    this.$el.text('Follow!');
  }
};

FollowToggle.prototype.toggleState = function () {
    if (this.followState === 'followed'){
      this.followState = 'unfollowed';
    } else {
      this.followState = 'followed';
    }
};

FollowToggle.prototype.handleClick = function () {
  this.$el.on('click', (e) => {
    e.preventDefault();
    if (this.followState === "followed") {
      API.unfollowUser(this.userId).then(
      (res) => this.toggleState()
    ).then(
      (res) => this.render()
    );
    } else {
      API.followUser(this.userId).then(
      (res) => this.toggleState()
    ).then(
      (res) => this.render()
    );
    }

  });
};

module.exports = FollowToggle;
