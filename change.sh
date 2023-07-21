#!/bin/sh
# Goal: Implement "execute" endpoint in backend
# Plan:
# 1. Create a new file "executeHandler.js" in the "handlers" directory.
# 2. In "executeHandler.js", import the "executeAndForwardOutput" function from "executeAndForwardOutput.js".
# 3. Define a function "executeHandler" that takes "req" and "res" as parameters.
# 4. In "executeHandler", call "executeAndForwardOutput" with "req.body.change" as the argument and a callback function that sends the response with the result.
# 5. Export "executeHandler" from "executeHandler.js".
# 6. In "setupRoutes.js", import "executeHandler" from "executeHandler.js".
# 7. Add a new POST route "/execute" that uses "executeHandler".

cat << EOF > ./src/backend/handlers/executeHandler.js
import { executeAndForwardOutput } from '../../execute/executeAndForwardOutput.js';

function executeHandler(req, res) {
  executeAndForwardOutput(req.body.change, (result) => {
    res.json({ result });
  });
}

export { executeHandler };
EOF

sed -i '' 's/import { listTasks } from '\''.\/handlers\/listTasks.js'\'';/import { listTasks } from '\''.\/handlers\/listTasks.js'\'';\
import { executeHandler } from '\''.\/handlers\/executeHandler.js'\'';/g' ./src/backend/setupRoutes.js

sed -i '' 's/app.post('\''\/updatetask'\'', updateTaskHandler);/app.post('\''\/updatetask'\'', updateTaskHandler);\
app.post('\''\/execute'\'', executeHandler);/g' ./src/backend/setupRoutes.js
