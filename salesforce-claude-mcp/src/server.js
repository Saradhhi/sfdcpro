/**
 * MCP Server — Salesforce + Claude Integration
 * Exposes Salesforce SOQL, DML & object describe as MCP tools for Claude.
 * Author: Vijaya Saradhi Meka
 */
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import { CallToolRequestSchema, ListToolsRequestSchema } from '@modelcontextprotocol/sdk/types.js';
import { SalesforceClient } from './salesforceClient.js';
import 'dotenv/config';

const sf = new SalesforceClient();
const server = new Server({ name: 'salesforce-mcp', version: '1.0.0' }, { capabilities: { tools: {} } });

server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [
    { name: 'sf_query',    description: 'Run a SOQL query against Salesforce',            inputSchema: { type:'object', properties:{ soql:{type:'string'} }, required:['soql'] } },
    { name: 'sf_describe', description: 'Describe a Salesforce object and its fields',     inputSchema: { type:'object', properties:{ objectName:{type:'string'} }, required:['objectName'] } },
    { name: 'sf_create',   description: 'Create a Salesforce record',                      inputSchema: { type:'object', properties:{ objectName:{type:'string'}, fields:{type:'object'} }, required:['objectName','fields'] } },
    { name: 'sf_update',   description: 'Update a Salesforce record by Id',                inputSchema: { type:'object', properties:{ objectName:{type:'string'}, id:{type:'string'}, fields:{type:'object'} }, required:['objectName','id','fields'] } },
  ]
}));

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  await sf.connect();
  const { name, arguments: args } = request.params;
  try {
    let result;
    if (name === 'sf_query')    result = await sf.query(args.soql);
    if (name === 'sf_describe') result = await sf.describe(args.objectName);
    if (name === 'sf_create')   result = await sf.create(args.objectName, args.fields);
    if (name === 'sf_update')   result = await sf.update(args.objectName, args.id, args.fields);
    return { content: [{ type:'text', text: JSON.stringify(result, null, 2) }] };
  } catch (err) {
    return { content: [{ type:'text', text: `Error: ${err.message}` }], isError: true };
  }
});

const transport = new StdioServerTransport();
await server.connect(transport);
console.error('Salesforce MCP Server running...');
