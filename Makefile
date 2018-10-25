.ONESHELL:
SHELL := /bin/bash
CHART_NAME ?= web-socket-stack
RELEASE_NAME := $(CHART_NAME)
PUBLIC_HELM_REPO_NAME := stakater-public
PUBLIC_HELM_REPO_URL := https://stakater.github.io/stakater-charts
NAMESPACE_NAME := lab

setup:
	helm init
	helm repo add $(PUBLIC_HELM_REPO_NAME) $(PUBLIC_HELM_REPO_URL)
	helm repo update

clean: 
	rm -rf $(CHART_NAME)/charts
	rm -rf $(CHART_NAME)/tmpcharts
	rm -rf $(CHART_NAME)/requirements.lock

build: clean setup
	helm dependency build $(CHART_NAME)
	$(MAKE) lint-chart

lint-chart:
	helm lint $(CHART_NAME)

install: build
	helm upgrade --install --wait --force --recreate-pods $(RELEASE_NAME) $(CHART_NAME) --namespace $(NAMESPACE_NAME) || exit 1

install-dry-run: 
	helm upgrade --install --wait --force --recreate-pods $(RELEASE_NAME) $(CHART_NAME) --namespace $(NAMESPACE_NAME) --dry-run

delete:
	helm delete $(RELEASE_NAME) --purge