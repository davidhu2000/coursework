let Inbox = {
  render: function() {
    let ul = document.createElement('ul');
    ul.innerHTML = 'An inbox message';
    ul.classList.add('messages');
    return ul;
  }
};

module.exports = Inbox;
