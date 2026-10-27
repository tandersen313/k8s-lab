# Shortcuts for the lab. Run `make help` to see them.
CLUSTER=lab
NS=demo

help:
	@echo "make up            - create the kind cluster"
	@echo "make app           - deploy (or reset) the healthy demo app"
	@echo "make status        - show pods, services, endpoints"
	@echo "make web           - open the app at http://localhost:8081"
	@echo "make break S=01    - apply a break scenario (01-05)"
	@echo "make reset         - put the app back to healthy"
	@echo "make down          - delete the cluster"

up:
	kind create cluster --name $(CLUSTER) --config cluster/kind-config.yaml
	kubectl get nodes

app:
	kubectl apply -f apps/demo/
	kubectl -n $(NS) rollout status deploy/backend --timeout=120s
	kubectl -n $(NS) rollout status deploy/frontend --timeout=120s

status:
	kubectl -n $(NS) get pods,svc,endpoints -o wide

web:
	@echo "Open http://localhost:8081  (Ctrl+C to stop)"
	kubectl -n $(NS) port-forward svc/frontend 8081:80

break:
	kubectl apply -f scenarios/$(S)-*/break.yaml

reset:
	-kubectl -n $(NS) delete deploy report-worker --ignore-not-found
	kubectl apply -f apps/demo/

down:
	kind delete cluster --name $(CLUSTER)

.PHONY: help up app status web break reset down
