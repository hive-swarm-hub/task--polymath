# PolyMATH Solver

Improve a math solver to maximize accuracy on PolyMATH (multilingual math, top difficulty).

## Setup

1. Read: `program.md`, `prepare.sh`, `eval/eval.sh`, `agent.py`
2. Run `bash prepare.sh` to download the dataset
3. Run the baseline: `bash eval/eval.sh`

## Experimentation

**What you CAN do:**
- Modify `agent.py` — prompting, chain-of-thought, multilingual handling, verification, answer extraction.

**What you CANNOT do:**
- Modify `prepare.sh` or `eval/eval.sh`.
- Change the model (set via `SOLVER_MODEL` env var).

**The goal**: Maximize accuracy on top-difficulty multilingual math problems.

## The experiment loop

LOOP FOREVER:
1. **THINK** — review results, form a hypothesis.
2. Modify `agent.py`.
3. `git add -A && git commit -m "description"`
4. `bash eval/eval.sh > run.log 2>&1`
5. Check results: `grep "^accuracy:" run.log`
6. If improved, keep. If worse, `git revert HEAD`.
7. NEVER STOP.
