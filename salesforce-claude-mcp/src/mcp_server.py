"""
Salesforce MCP Server — connects Claude to Salesforce CRM via MCP protocol.
Author: Vijaya Saradhi Meka
"""
import os
from dotenv import load_dotenv
from simple_salesforce import Salesforce

load_dotenv()

def get_sf_connection():
    return Salesforce(
        username=os.getenv("SF_USERNAME"),
        password=os.getenv("SF_PASSWORD"),
        security_token=os.getenv("SF_SECURITY_TOKEN"),
        domain=os.getenv("SF_DOMAIN", "login"),
    )

def query_salesforce(soql: str) -> dict:
    """Execute a SOQL query and return results."""
    sf = get_sf_connection()
    result = sf.query_all(soql)
    return {"totalSize": result["totalSize"], "records": result["records"]}

def get_object_fields(object_name: str) -> list:
    """Return all field names for a given Salesforce object."""
    sf = get_sf_connection()
    meta = getattr(sf, object_name).describe()
    return [f["name"] for f in meta["fields"]]

# MCP tool definitions for Claude
MCP_TOOLS = [
    {
        "name": "salesforce_query",
        "description": "Execute a SOQL query against Salesforce and return records.",
        "input_schema": {
            "type": "object",
            "properties": {"soql": {"type": "string", "description": "Valid SOQL query string"}},
            "required": ["soql"],
        },
    },
    {
        "name": "salesforce_describe",
        "description": "Get all field names for a Salesforce object.",
        "input_schema": {
            "type": "object",
            "properties": {"object_name": {"type": "string", "description": "API name of the Salesforce object"}},
            "required": ["object_name"],
        },
    },
]

if __name__ == "__main__":
    print("🚀 Salesforce MCP Server ready")
    print(f"📡 Tools available: {[t['name'] for t in MCP_TOOLS]}")
