import http from 'k6/http';

export const options = {
  vus: 10,
  duration: '10m',
};

export default function () {
  http.get('https://google.com/');
}

export function handleSummary(data) {
  return {
    'summary.json': JSON.stringify(data), //the default data object
  };
}
