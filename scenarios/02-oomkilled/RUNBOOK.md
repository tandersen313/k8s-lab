# Scenario 02: The report job dies every few seconds

## The customer ticket
> "Our new report-worker keeps restarting. Logs just stop mid-run with no error. Is your platform killing our pods?"

**Break it:** `make break S=02`  **Reset:** `make reset`

## Starter commands
- `kubectl -n demo get pods`
- `kubectl -n demo describe pod <report-worker-pod>` (look at **Last State** and **Reason**)
- `kubectl -n demo get events --sort-by=.lastTimestamp`
- Optional: `kubectl top pod -n demo` (needs metrics-server; a good stretch goal to install)

## My investigation
```
```

## Root cause

## Fix

## Prevention

## How I'd explain it to the customer

## Time to resolve

<details><summary>Answer key (open after you're done)</summary>

Last State: Terminated, Reason **OOMKilled**, exit code **137**. The container grew past its 64Mi memory limit and the kernel killed it, so there's no app error in the logs. "Is the platform killing our pods?" is half right: it's enforcing the limit *they* set. Fix: right-size the memory limit or fix the memory leak (here, the leak is intentional). Prevention: memory monitoring/alerts, load-test new workloads, use requests/limits based on observed usage. This is exactly the ScaleOps / right-sizing conversation.
</details>
