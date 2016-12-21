const FollowToggle = function($el) {
  this.$el = $el;
  this.userId = $el.data("user-id");
  console.log($el.data("initial-follow-state"));
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

FollowToggle.prototype.handleClick = function () {
  this.$el.on('click', (e) => {
    e.preventDefault();
    let ajaxMethod;

    if (this.followState === 'followed'){
      ajaxMethod = "delete";
      this.followState = 'unfollowed';
      // this.initialFollowState = true;
    } else {
      ajaxMethod = "post";
      this.followState = 'followed';
      // this.initialFollowState = false;
    }

    $.ajax({
      method: ajaxMethod,
      url: `/users/${this.userId}/follow/`,
      dataType: "json",
      success: () => {
        this.render();
      }
    });
  });
};

module.exports = FollowToggle;
