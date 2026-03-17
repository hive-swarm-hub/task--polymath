#!/usr/bin/env bash
set -euo pipefail
mkdir -p data
echo "Downloading PolyMATH..."
python3 -c "
from datasets import load_dataset
import json, pathlib, random

random.seed(42)

dev = list(load_dataset('Qwen/PolyMath', 'en', split='high'))
random.shuffle(dev)
dev_out = pathlib.Path('data/dev.jsonl')
with dev_out.open('w') as f:
    for row in dev[:150]:
        f.write(json.dumps({'question': row['question'], 'answer': str(row['answer'])}) + '
')

test = list(load_dataset('Qwen/PolyMath', 'en', split='top'))
random.shuffle(test)
test_out = pathlib.Path('data/test.jsonl')
with test_out.open('w') as f:
    for row in test[:150]:
        f.write(json.dumps({'question': row['question'], 'answer': str(row['answer'])}) + '
')

print(f'Dev:  {min(len(dev),150)} problems -> {dev_out}')
print(f'Test: {min(len(test),150)} problems -> {test_out}')
"
echo "Done."
