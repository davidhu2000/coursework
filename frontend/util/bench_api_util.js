export const fetchBenches = (successCallback) => {
  return $.ajax({
    method: 'GET',
    url: '/api/benches',
    success: res => successCallback(res),
    error: err => console.log(err)
  });
};
