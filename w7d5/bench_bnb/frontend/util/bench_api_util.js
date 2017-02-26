export const fetchBenches = (filters, success) => {
  return $.ajax({
    method: 'GET',
    url: '/api/benches',
    data: filters
  });
};
