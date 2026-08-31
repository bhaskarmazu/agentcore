from strands import Agent
from strands_tools.browser import AgentCoreBrowser

browser_tool = AgentCoreBrowser(region="us-east-2", identifier="aws.browser.v1")

agent = Agent(tools=[browser_tool.browser])

response = agent("Go to example.com and tell me what the page says.")
print(response.message["content"][0]["text"])