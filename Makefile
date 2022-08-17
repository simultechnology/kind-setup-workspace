
.PHONY: setup-v6
setup-v6:
	sh assets/kind/kind-v6-with-registry.sh ipv6-cluster

.PHONY: setup-v4
setup-v4:
	sh assets/kind/kind-v4-with-registry.sh ipv4-cluster

.PHONY: clean-v6
clean-v6:
	kind delete cluster --name ipv6-cluster

.PHONY: clean-v4
clean-v4:
	kind delete cluster --name ipv4-cluster

.PHONY: clean
clean:
	kind delete cluster --name ipv4-cluster
	kind delete cluster --name ipv6-cluster
