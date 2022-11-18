import { Worker } from 'bullmq';
const { Sequelize, DataTypes } = require('sequelize');

const sequelize = new Sequelize('postgres://postgres:postgres@postgres:5432/api_data');
(async () => {
  try {
    await sequelize.authenticate();
    console.log('Connection has been established successfully.');
  } catch (error) {
    console.error('Unable to connect to the database:', error);
    process.exit(1);
  }
})();

const redisConnection = {
  host: 'redis',
  port: 6379
};

const Organization = sequelize.define('Organization', {
  identifier: {
    type: DataTypes.STRING,
    allowNull: false
  },
  businessName: {
    type: DataTypes.STRING,
    allowNull: false
  },
  dba: {
    type: DataTypes.STRING,
    allowNull: false
  },
  ein: {
    type: DataTypes.STRING,
    allowNull: false
  },
  businessCity: {
    type: DataTypes.STRING,
    allowNull: false
  }
}, {
  // Other model options go here
});

const myWorker = new Worker(
  'conversation',
  async ({ name, data }) => {
    console.log('job name: ', name);
    console.log('job value: ', data.value);

    await sequelize.sync({ force: true });
    const org = Organization.build(data.value);
    await org.save();
  },
  { connection: redisConnection }
);

myWorker.on('completed', (job) => {
  console.log('Job \'' + job.name + '\' completed.');
});

myWorker.on('drained', () => {
  console.log('Jobs drained.');
});

myWorker.on('failed', (jobId: string, error: Error) => {
  console.error('myWorker :: ERROR; jobId = ' + jobId);
  console.error(error);
});
