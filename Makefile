ANSIBLE_CMD_PREFIX := cd ansible &&

default: help

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@echo "Usage: make [target]"
	@echo "This is a Makefile for aliasing of common commands."
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: devel
devel: # Ensure development environment
	$(ANSIBLE_CMD_PREFIX) ansible-playbook devel.yml --extra-vars '{"container_state": "started"}'

.PHONY: enter
enter: devel # Enter into a shell inside the container
	podman exec -it ros2-devel bash


.PHONY: stop
stop: # Stop container for development
	$(ANSIBLE_CMD_PREFIX) ansible-playbook devel.yml --extra-vars '{"container_state": "stopped"}'
