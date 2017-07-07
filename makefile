################################################################################
# Author : Christian Amstutz
# Date   : 2017-06-29
################################################################################

SCRIPT_DIR = scripts

.PHONY: all
all:
	vivado -mode batch -source $(SCRIPT_DIR)/full_implementation.tcl

# make target for a testbench simulation in Vivado
.PHONY: sim_workflow_test
sim_workflow_test:
	bash $(SCRIPT_DIR)/run_tb.sh tb/workflow_test testbench

# target for automated documentation creation
.PHONY: doc
doc:
	doxygen doc/doxygen/doxyfile
	-@ln -s ./html/index.html doc/doxygen/index.html -f

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
