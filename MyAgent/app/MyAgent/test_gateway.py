import asyncio
from mcp import ClientSession
from mcp.client.streamable_http import streamablehttp_client

GATEWAY_URL = "https://myagent-mygateway-khbm9bxkns.gateway.bedrock-agentcore.us-east-2.amazonaws.com/mcp"

async def main():
    async with streamablehttp_client(GATEWAY_URL) as (read, write, _):
        async with ClientSession(read, write) as session:
            await session.initialize()
            result = await session.call_tool(
                "x_amz_bedrock_agentcore_search",
                {"query": "search the web for information"},
            )
            print(result)

asyncio.run(main())