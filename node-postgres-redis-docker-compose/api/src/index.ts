import express from 'express';
import bodyParser from 'body-parser';
import { Client } from 'pg';
import { /* QueueScheduler, */ Queue } from 'bullmq';
import { validate_organization } from './validator';
import moment from 'moment';

import { IOrganization, IPingResponse } from './interfaces';

const redisConnection = {
  host: 'redis',
  port: 6379
};

// TODO: QueueScheduler should be probably run as a separate process.
// const myScheduler = new QueueScheduler('conversation', { connection: redisConnection });

const myQueue = new Queue('conversation', { connection: redisConnection });

async function addOrganization(org:IOrganization) {
  await myQueue.add('add_org', { value: org });
}

const PORT = process.env.PORT || 3000;

const client = new Client({
  password: 'postgres',
  user: 'postgres',
  host: 'postgres',
});

const app = express();
app.use(bodyParser.json());

app.get('/ping', async (req, res) => {
  const pgStatus = await client.query('SELECT 1 + 1').then(() => 'up').catch(() => 'down');
  const jobStates = ['waiting', 'active', 'completed', 'failed', 'delayed'];

  const response: IPingResponse = {
    environment: process.env.NODE_ENV,
    postgres_db: pgStatus,
    pong: 'OK'
  };

  for (let i = 0; i < jobStates.length; i += 1) {
    const state = jobStates[i];
    const status = await myQueue.getJobCounts(state);
    response[state + '_jobs'] = status[state];
  }

  res.send(response);
});

app.post('/organizations', async (req, res) => {
  const processParam = req.query.process;

  console.log('processParam = \'' + processParam + '\'');
  console.log('req.body = ', req.body);

  if (processParam === 'false') {
    res.send({
      data: {
        organization: req.body
      }
    });

    return;
  } else if (processParam === 'true') {
    let validatedOrg = validate_organization(req.body);

    if (validatedOrg === null) {
      res.status(500);
      res.send({ error: 'Organization validation failed.' });

      return;
    }

    addOrganization(validatedOrg);

    res.send({
      data: {
        organization: validatedOrg
      },
      result: {
        status: 'PROCESSED',
        createdAt: moment().format()
      }
    });

    return;
  } else {
    res.status(500);
    res.send({ error: '"process" query parameter must be properly set.' });

    return;
  }
});

(async () => {
  await client.connect();

  app.listen(PORT, () => {
    console.log('Started at http://localhost:' + PORT);
  });
})();
