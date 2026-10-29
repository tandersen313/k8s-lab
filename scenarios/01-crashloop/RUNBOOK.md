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
make status                                    # 1 backend pod CrashLoopBackOff, 286 restarts; 2 older backend pods healthy
kubectl -n demo describe pod <crashing-pod>    # Exit Code 2, started and died in the same second; image pulled fine
kubectl -n demo logs <crashing-pod> --previous # Error: unknown flag: --cache-ttl-seconds
kubectl -n demo rollout status deploy/backend  # exceeded its progress deadline: rollout stuck
diff apps/demo/20-backend.yaml scenarios/01-crashloop/break.yaml  # one added arg is the only real change
```
Ruled out: image problems (pulled fine), probes (app died before they ran), resource limits (exit code 2, not 137).

## Root cause
The config change added `--cache-ttl-seconds=300` to the backend's container args. podinfo 6.7.1 doesn't support that flag, so the app exits immediately on startup (exit code 2), and Kubernetes keeps restarting it.

## Fix
Re-applied the known-good manifest from the repo (`make reset` → `kubectl apply -f apps/demo/`). The broken pod was removed and the rollout completed.

**Gotcha I hit:** after resetting, I also ran `kubectl rollout undo`, which re-broke it. `undo` goes back to the *previous* revision, not the last good one, and the previous revision was the broken one. Lesson: check `rollout history` before undoing, and treat Git as the source of truth.

## Prevention
- Validate config in CI before deploy (for example, run the container with its args in a test step)
- Roll out to staging first
- Record why each change was made (`kubernetes.io/change-cause` annotation) so `rollout history` is readable

## How I'd explain it to the customer
Your site actually stayed up. Kubernetes kept the previous backend version running and never sent traffic to the new pod, because it never became healthy. The change added a startup setting this version of the app doesn't support, so the new pods failed instantly. We removed the setting and redeployed, and going forward we'd suggest validating config changes in CI or staging first.

## Time to resolve
About 30 minutes of diagnosis once I started investigating.

<details><summary>Answer key (open after you're done)</summary>

Status `CrashLoopBackOff`. `logs --previous` shows podinfo exiting on an **unknown flag** in the container args. The "small config change" added an argument the app doesn't support. Fix: remove the bad arg (`make reset`). Prevention: validate config in CI, use a staging rollout, and note that rolling updates kept the old pods alive only if the new ones never became Ready — check whether that happened here and why.
</details>