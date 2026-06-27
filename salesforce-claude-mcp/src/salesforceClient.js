/**
 * Salesforce connection client using jsforce + OAuth2.
 * Author: Vijaya Saradhi Meka
 */
import jsforce from 'jsforce';

export class SalesforceClient {
  constructor() { this.conn = null; }

  async connect() {
    if (this.conn?.accessToken) return;
    this.conn = new jsforce.Connection({
      loginUrl: process.env.SF_LOGIN_URL ?? 'https://login.salesforce.com'
    });
    await this.conn.login(process.env.SF_USERNAME, process.env.SF_PASSWORD + process.env.SF_SECURITY_TOKEN);
  }

  async query(soql) {
    const result = await this.conn.query(soql);
    return { totalSize: result.totalSize, done: result.done, records: result.records };
  }

  async describe(objectName) {
    const meta = await this.conn.describe(objectName);
    return { name: meta.name, label: meta.label, fields: meta.fields.map(f => ({ name:f.name, type:f.type, label:f.label })) };
  }

  async create(objectName, fields) {
    return await this.conn.sobject(objectName).create(fields);
  }

  async update(objectName, id, fields) {
    return await this.conn.sobject(objectName).update({ Id: id, ...fields });
  }
}
