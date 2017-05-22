################################################################################
# Author : Christian Amstutz
# Date   : 2017-05-19
################################################################################

SCRIPT_DIR = scripts

.PHONY: all
all:
	vivado -mode batch -source $(SCRIPT_DIR)/full_implementation.tcl

.PHONY: sim_or_gate
sim_or_gate:
	bash $(SCRIPT_DIR)/run_tb.sh tb/or_gate testbench

.PHONY: clean
clean:
	vivado -mode batch -source $(SCRIPT_DIR)/clean_up_generated.tcl
	-@rm workflow_test.bit -f
	-@rm output -r -f
	-@rm .Xil -r -f
	-@rm xsim.dir -r -f
	-@rm ./*.log -f
	-@rm ./*.jou -f
	-@rm vivado_pid*.str -f
	-@rm ./*.pb -f
	-@rm ./results.txt -f
