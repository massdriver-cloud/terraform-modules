// https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/63c55c787e77f207392bc0ec9b96790707794c64/functions/helloworld

'use strict';

/* eslint-disable no-unused-vars */

// [START functions_helloworld_http]
// [START functions_helloworld_get]
const functions = require('@google-cloud/functions-framework');
// [END functions_helloworld_get]
const escapeHtml = require('escape-html');
// [END functions_helloworld_http]

// [START functions_helloworld_get]

// Register an HTTP function with the Functions Framework that will be executed
// when you make an HTTP request to the deployed function's endpoint.
functions.http('helloGET', (req, res) => {
  res.send('Hello World!');
});
// [END functions_helloworld_get]

// [START functions_helloworld_http]

/**
 * Responds to an HTTP request using data from the request body parsed according
 * to the "content-type" header.
 *
 * @param {Object} req Cloud Function request context.
 * @param {Object} res Cloud Function response context.
 */
functions.http('helloHttp', (req, res) => {
  res.send(`Hello ${escapeHtml(req.query.name || req.body.name || 'World')}!`);
});
// [END functions_helloworld_http]
