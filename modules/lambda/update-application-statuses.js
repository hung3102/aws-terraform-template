const https = require('https');

exports.handler = async () => {
  const url = new URL(process.env.API_BASE_URL); // e.g., https://api.example.com/path

  const options = {
    hostname: url.hostname,
    path: "/batch/update-application-statuses",
    method: 'POST',
    headers: {
      'x-scheduler-token': process.env.SCHEDULER_SECRET_TOKEN,
    },
  };

  return new Promise((resolve, reject) => {
    const req = https.request(options, (res) => {
      let body = '';
      res.on('data', (chunk) => (body += chunk));
      res.on('end', () => resolve({ statusCode: res.statusCode, body }));
    });

    req.on('error', reject);
    req.end();
  });
};
