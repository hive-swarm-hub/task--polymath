"""PolyMATH solver — solves multilingual math problems.

Takes a math problem on stdin, prints the answer on stdout.
"""
import sys, os, re
from openai import OpenAI

def solve(question: str) -> str:
    client = OpenAI()
    response = client.chat.completions.create(
        model=os.environ.get("SOLVER_MODEL", "gpt-4.1-nano"),
        messages=[
            {"role": "system", "content": "Solve the math problem. The problem may be in any language. Give ONLY the final numeric answer, nothing else."},
            {"role": "user", "content": question},
        ],
        temperature=0,
        max_tokens=1024,
    )
    answer = response.choices[0].message.content.strip()
    match = re.search(r'\\boxed\{(.+?)\}', answer)
    if match:
        return match.group(1)
    numbers = re.findall(r'-?\d+\.?\d*', answer)
    return numbers[-1] if numbers else answer

if __name__ == "__main__":
    print(solve(sys.stdin.read().strip()))
