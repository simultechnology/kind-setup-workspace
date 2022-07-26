
.PHONY: setup-v6
setup:
	sh assets/kind/kind-v6-with-registry.sh ipv6-cluster

.PHONY: setup-v4
setup:
	sh assets/kind/kind-v4-with-registry.sh ipv4-cluster

.PHONY: clean-v6
clean:
	kind delete cluster --name ipv6-cluster

.PHONY: clean-v4
clean:
	kind delete cluster --name ipv4-cluster

.PHONY: clean
clean:
	kind delete cluster --name ipv4-cluster
	kind delete cluster --name ipv6-cluster
