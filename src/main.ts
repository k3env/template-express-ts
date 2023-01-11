import * as express from 'express';
import cors from 'cors';
import * as dotenv from 'dotenv';

dotenv.config();

export async function main(): Promise<void> {
  const app = express.default();

  app.use(express.json());
  app.use(cors({ origin: '*' }));
  app.use('/', (req, res) => {
    res.send({ hello: 'world' });
  });
  app.listen(3000, () => {
    console.log('it works (v0.3) on 0.0.0.0:3000');
  });
}

main();
