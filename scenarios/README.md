# Scenarios

Each folder is one break-and-fix exercise:

1. `make reset` so the app is healthy (`make status` — everything Ready)
2. `make break S=NN`
3. Open the folder's `RUNBOOK.md`, read **only the customer ticket**, and troubleshoot
4. Fill in the runbook with real command output, root cause, fix, and the customer explanation
5. Check the answer key, then `make reset`
6. Repeat it a week later and record a faster time

| # | Scenario | Skill it builds |
|---|---|---|
| 01 | CrashLoopBackOff | logs, `--previous`, config errors |
| 02 | OOMKilled | resource limits, exit codes, right-sizing |
| 03 | ImagePullBackOff | events, rollouts, image hygiene |
| 04 | Running but not Ready | probes, Services, endpoints |
| 05 | Pending | scheduling, requests vs. capacity |

**Ideas for 06+ (write these yourself):** Service selector typo, missing ConfigMap/Secret, broken DNS, NetworkPolicy blocking traffic, RBAC "forbidden" errors, PVC stuck Pending, node drained during peak.
