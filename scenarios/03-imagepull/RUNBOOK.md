# Scenario 03: The new frontend won't start

## The customer ticket
> "We upgraded the frontend image tag and the new pods are stuck. Old pods are still serving, but the rollout never finishes."

**Break it:** `make break S=03`  **Reset:** `make reset`

## Starter commands
- `kubectl -n demo get pods`
- `kubectl -n demo describe pod <stuck-pod>` (read the **Events** at the bottom)
- `kubectl -n demo rollout status deploy/frontend`

## My investigation
```
```

## Root cause

## Fix

## Prevention

## How I'd explain it to the customer

## Time to resolve

<details><summary>Answer key (open after you're done)</summary>

Status `ErrImagePull` → `ImagePullBackOff`. Events show the tag **doesn't exist** (typo: `alpne`). Note the good news to tell the customer: the rolling update protected them — old pods kept serving because new ones never became ready. Fix: correct the tag. Prevention: pin image digests, validate tags in CI, admission policy (Kyverno, later in this lab) to allow only approved registries.
</details>
