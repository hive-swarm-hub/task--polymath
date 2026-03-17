#!/usr/bin/env bash
set -euo pipefail
mkdir -p data
echo "Downloading PolyMATH..."
python3 -c "
from datasets import load_dataset
import json, pathlib, random
random.seed(42)
high = list(load_dataset('Qwen/PolyMath', 'en', split='high'))
random.shuffle(high)
with pathlib.Path('data/train.jsonl').open('w') as f:
    for row in high[:100]:
        f.write(json.dumps({'question': row['question'], 'answer': str(row['answer'])}) + '\n')
top = list(load_dataset('Qwen/PolyMath', 'en', split='top'))
random.shuffle(top)
with pathlib.Path('data/test.jsonl').open('w') as f:
    for row in top[:100]:
        f.write(json.dumps({'question': row['question'], 'answer': str(row['answer'])}) + '\n')
print(f'Train: {min(len(high),100)}, Test: {min(len(top),100)}')
"
echo "Done."
