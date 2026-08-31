from strands import Agent
from strands_tools.code_interpreter import AgentCoreCodeInterpreter

code_interpreter_tool = AgentCoreCodeInterpreter(region="us-east-2")

agent = Agent(
    tools=[code_interpreter_tool.code_interpreter],
    system_prompt=(
        "You are an AI assistant that validates answers through code execution. "
        "When asked about calculations or algorithms, write Python code to verify your answer."
    ),
)

response = agent("What is the 20th Fibonacci number? Write and run code to check.")
print(response.message["content"][0]["text"])