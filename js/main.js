document.addEventListener('DOMContentLoaded', () => {
  let sidebar = document.getElementsByClassName('sidebar-nav')[0];

  sidebar.addEventListener('click', event => {
    let hash = event.target.innerHTML.toLowerCase();

    window.location.hash = hash;
  });
});
