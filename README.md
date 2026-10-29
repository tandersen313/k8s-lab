# Kubernetes Break-and-Fix Lab

A hands-on lab where I run a small multi-service app on a local Kubernetes cluster, break it in realistic ways, troubleshoot it, and write customer-facing runbooks for each failure.

**Why:** In customer-facing technical roles (TAM / CSE), the job isn't just fixing the problem. It's diagnosing it fast from a vague ticket, and explaining it so the customer trusts the answer. Every scenario here ends with "how I'd explain it to the customer."

## Architecture

```
            ┌────────────┐      ┌────────────┐      ┌─────────┐
browser ──▶ │  frontend  │ ───▶ │  backend   │ ───▶ │  redis  │
            │ nginx (x2) │      │ podinfo x2 │      │ cache   │
            └────────────┘      └────────────┘      └─────────┘
                    kind cluster "lab": 1 control plane + 2 workers
```

## Stack
| Layer | Tool | Phase |
|---|---|---|
| Cluster | kind on Docker Desktop (Apple Silicon Mac) | 1 ✅ |
| App | nginx → podinfo → redis | 1 ✅ |
| Troubleshooting | kubectl, k9s, runbooks | 1 ✅ |
| GitOps | Argo CD | 2 |
| Runtime security | Falco | 3 |
| Image scanning | Trivy | 3 |
| Policy | Kyverno | 3 |

## Quick start
```bash
make up        # create the cluster
make app       # deploy the healthy app
make status    # check everything is Ready
make web       # browse to http://localhost:8081
```
Then pick a scenario in [`scenarios/`](scenarios/).

## Scenarios
| # | Failure | Status |
|---|---|---|
| 01 | CrashLoopBackOff | ✅ |
| 02 | OOMKilled | ⬜ |
| 03 | ImagePullBackOff | ⬜ |
| 04 | Running but not Ready | ⬜ |
| 05 | Pending / unschedulable | ⬜ |

## How I built this
I built this lab with Claude as a pair: Claude scaffolded the cluster config, manifests, and scenarios; I ran every scenario, troubleshot it myself, and wrote the runbooks from real output. See [`notes/learning-log.md`](notes/learning-log.md).

## Repo layout
```
cluster/    kind cluster config
apps/demo/  the healthy app (also the "reset" state)
scenarios/  break-and-fix exercises + runbooks
gitops/     Argo CD (phase 2)
security/   Falco, Trivy, Kyverno (phase 3)
notes/      learning log
```
