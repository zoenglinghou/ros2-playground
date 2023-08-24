default: help

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: devel
devel: # Ensure development environment
	cd ansible && ansible-playbook devel.yml

.PHONY: enter
enter: # Enter into a shell inside the container
	podman exec -it ros2-devel bash
