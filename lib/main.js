const DOMNodeCollection = require('./dom_node_collection.js');

window.$l = element => {
  let nodes;
  if (element instanceof HTMLElement) {
    nodes = element;
  } else if (typeof element === 'string') {
    nodes = document.querySelectorAll(element);
  }
  nodes = [].slice.call(nodes);
  return new DOMNodeCollection(nodes);
};

window.$l.extend = (mainObj, ...objs) => {
  objs.forEach( obj => {
    for(let key in obj) {
      mainObj[key] = obj[key];
    }
  });
  return mainObj;
};

window.$l.ajax = options => {
  let defaultOptions = {
    method: 'GET',
    contentType: 'HTML',
    data: '',
    success: (res) => {
      return res;
    },
    error: (err) => {
      return err;
    }
  };

  options = window.$l.extend(defaultOptions, options);
  if (options['url'] === undefined) throw 'ajax request require url.';
  const xhr = new XMLHttpRequest();
  xhr.open(options['method'], options['url']);

  xhr.onload = function () {
    console.log(xhr.status); // for status info
    console.log(xhr.responseType); //the type of data that was returned
    console.log(xhr.response); //the actual response. For json api calls, this will be a json string
  };

  xhr.send();

  return xhr.response;
};
