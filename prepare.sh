#!/usr/bin/env bash
set -euo pipefail
mkdir -p data
echo "Downloading PolyMATH..."
python3 -c "
from datasets import load_dataset
import json, pathlib

dev = load_dataset('Qwen/PolyMath', 'en', split='high')
dev_out = pathlib.Path('data/dev.jsonl')
with dev_out.open('w') as f:
    for row in dev:
        f.write(json.dumps({'question': row['question'], 'answer': str(row['answer'])}) + '\n')

test = load_dataset('Qwen/PolyMath', 'en', split='top')
test_out = pathlib.Path('data/test.jsonl')
with test_out.open('w') as f:
    for row in test:
        f.write(json.dumps({'question': row['question'], 'answer': str(row['answer'])}) + '\n')

print(f'Dev:  {len(dev)} problems (high difficulty) -> {dev_out}')
print(f'Test: {len(test)} problems (top difficulty) -> {test_out}')
"
echo "Done."
