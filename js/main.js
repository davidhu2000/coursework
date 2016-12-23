const Router = require('./router.js');

document.addEventListener('DOMContentLoaded', () => {
  let sidebar = document.getElementsByClassName('sidebar-nav')[0];

  sidebar.addEventListener('click', event => {
    let hash = event.target.innerHTML.toLowerCase();

    window.location.hash = hash;
    let router = new Router(document.querySelector('.content'));
    router.start();
  });
});
