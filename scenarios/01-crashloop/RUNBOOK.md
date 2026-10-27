# Scenario 01: The API keeps restarting

## The customer ticket
> "We pushed a small config change to the backend and now the site is down. Pods say Running for a second and then fail. Nothing changed in the code!"

**Break it:** `make break S=01`  **Reset:** `make reset`

## Starter commands
- `kubectl -n demo get pods -w` (watch the RESTARTS column)
- `kubectl -n demo describe pod <pod>`
- `kubectl -n demo logs <pod>` and `kubectl -n demo logs <pod> --previous`

## My investigation
```
```

## Root cause

## Fix

## Prevention

## How I'd explain it to the customer

## Time to resolve

<details><summary>Answer key (open after you're done)</summary>

Status `CrashLoopBackOff`. `logs --previous` shows podinfo exiting on an **unknown flag** in the container args. The "small config change" added an argument the app doesn't support. Fix: remove the bad arg (`make reset`). Prevention: validate config in CI, use a staging rollout, and note that rolling updates kept the old pods alive only if the new ones never became Ready — check whether that happened here and why.
</details>
