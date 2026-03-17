# PolyMATH Solver

Improve a math solver for PolyMATH top-difficulty problems.

## Setup

1. **Read the in-scope files**: The repo is small. Read these files for full context:
   - `agent.py` — the file you modify. The math solver.
   - `eval/eval.sh` — runs evaluation. Do not modify.
   - `prepare.sh` — downloads dataset. Do not modify.
2. **Run prepare**: `bash prepare.sh` to download the dataset.
3. **Verify data exists**: Check that `data/` contains `test.jsonl`.
4. **Initialize results.tsv**: Create `results.tsv` with just the header row.
5. **Run baseline**: `bash eval/eval.sh` to establish the starting accuracy.

## The benchmark

PolyMATH evaluates math reasoning on the hardest (top) difficulty tier. Problems span competition math, olympiad-level algebra, geometry, and combinatorics.

Total: **125 test problems**. The agent reads a math problem on stdin and prints the answer on stdout.

## Experimentation

**What you CAN do:**
- Modify `agent.py` — this is the only file you edit. Everything is fair game: prompting strategy, chain-of-thought, self-verification, answer extraction, few-shot examples.

**What you CANNOT do:**
- Modify `eval/`, `prepare.sh`, or test data.
- Change the model. The model is fixed (set via `SOLVER_MODEL` env var).
- Install new packages beyond what's in `requirements.txt`.

**The goal: maximize accuracy.** Accuracy = fraction of problems where your answer matches the ground truth (normalized string comparison).

**Cost** is a soft constraint. Some increase in API calls is acceptable for meaningful gains.

**Simplicity criterion**: All else being equal, simpler is better.

## Output format

```
---
accuracy:         0.5000
correct:          15
total:            30
```

## Logging results

Log each experiment to `results.tsv` (tab-separated):

```
commit\taccuracy\tcost_usd\tstatus\tdescription
a1b2c3d\t0.500000\t0.30\tkeep\tbaseline
b2c3d4e\t0.600000\t0.50\tkeep\tchain-of-thought + verification
```

## The experiment loop

LOOP FOREVER:

1. **THINK** — review results.tsv, form a hypothesis.
2. Modify `agent.py` with your experiment.
3. git commit
4. Run: `bash eval/eval.sh > run.log 2>&1`
5. Read results: `grep "^accuracy:" run.log`
6. If empty, check `tail -n 50 run.log` for errors.
7. Record in results.tsv (do not commit results.tsv).
8. If accuracy improved, keep. If not, `git reset --hard HEAD~1`.

**Timeout**: If a run exceeds 30 minutes, kill it.

**NEVER STOP**: Once the loop begins, do NOT pause to ask the human. You are autonomous. The loop runs until interrupted.
