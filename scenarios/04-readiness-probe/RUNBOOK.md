# Scenario 04: Pods are Running but the site returns errors

## The customer ticket
> "All our pods show Running, nothing is crashing, but the website returns 502 Bad Gateway. Your load balancer is broken."

**Break it:** `make break S=04`  **Reset:** `make reset`  **See it:** `make web`, then open http://localhost:8081

## Starter commands
- `kubectl -n demo get pods` (look closely at the **READY** column)
- `kubectl -n demo get endpoints backend`
- `kubectl -n demo describe pod <backend-pod>`
- `kubectl -n demo logs deploy/frontend`

## My investigation
```
```

## Root cause

## Fix

## Prevention

## How I'd explain it to the customer

## Time to resolve

<details><summary>Answer key (open after you're done)</summary>

Pods are `Running` but `0/1` READY. The readiness probe points at port **9989** instead of **9898**, so it always fails. Kubernetes removes unready pods from the Service, so `endpoints backend` is empty and nginx returns 502. Lesson for customers: **Running ≠ Ready**. Bonus question to think about: why didn't the liveness probe restart the pod? Prevention: review probe config in PRs; alert on Services with zero ready endpoints.
</details>
