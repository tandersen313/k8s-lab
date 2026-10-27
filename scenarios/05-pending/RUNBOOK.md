# Scenario 05: New pods never get scheduled

## The customer ticket
> "We scaled the backend up for a big launch and the new pods have been Pending for 20 minutes. Do we need more nodes?"

**Break it:** `make break S=05`  **Reset:** `make reset`

## Starter commands
- `kubectl -n demo get pods -o wide`
- `kubectl -n demo describe pod <pending-pod>` (Events: what does the scheduler say?)
- `kubectl describe nodes | grep -A5 "Allocated resources"`

## My investigation
```
```

## Root cause

## Fix

## Prevention

## How I'd explain it to the customer

## Time to resolve

<details><summary>Answer key (open after you're done)</summary>

Pods are `Pending`; Events show `FailedScheduling ... Insufficient cpu`. Someone set the CPU request to **64 cores** per pod (probably meant `64m`). No node can fit it, so more nodes wouldn't help either — a great "don't just throw money at it" customer moment. Fix: correct the request to a realistic value. Prevention: LimitRange / ResourceQuota per namespace, policy that caps requests, cost visibility.
</details>
