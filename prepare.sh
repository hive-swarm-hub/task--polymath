#!/usr/bin/env bash
set -euo pipefail
mkdir -p data
echo "Downloading PolyMATH (English, top difficulty)..."
python3 -c "
from datasets import load_dataset
import json, pathlib
ds = load_dataset('Qwen/PolyMath', 'en', split='top')
out = pathlib.Path('data/test.jsonl')
with out.open('w') as f:
    for row in ds:
        f.write(json.dumps({'question': row['question'], 'answer': str(row['answer'])}) + '\n')
print(f'Wrote {len(ds)} problems to {out}')
"
echo "Done. $(wc -l < data/test.jsonl) problems"
