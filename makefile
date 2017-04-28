################################################################################
# Author : Christian Amstutz
# Date   : 2017-04-26
################################################################################

IP_DIRS = ip/multiplier

SCRIPT_DIR = scripts

.PHONY: all
all:
	vivado -mode batch -source $(SCRIPT_DIR)/full_implementation.tcl

.PHONY: sim_or_gate
sim_or_gate:
	bash $(SCRIPT_DIR)/run_tb.sh tb/or_gate testbench

.PHONY: clean
clean:
	-@rm workflow_test.bit -f
	-@rm output -r -f
	-@rm .Xil -r -f
	-@rm xsim.dir -r -f
	-@rm *.log -f
	-@rm *.jou -f
	-@rm vivado_pid*.str -f
	-@rm xelab.pb -f
	@bash $(SCRIPT_DIR)/clean_ip_folder.sh $(IP_DIRS)
