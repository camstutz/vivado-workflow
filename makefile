TB_DIRS = tb/or_gate
SCRIPT_DIR = scripts

.PHONY: all
all:
	vivado -mode batch -source $(SCRIPT_DIR)/full_implementation.tcl

.PHONY: sim_or_gate
sim_or_gate:
	bash $(SCRIPT_DIR)/run_tb.sh or_gate testbench

.PHONY: clean
clean:
	-@rm -f or_gate.bit
	-@rm -f vivado -r
	-@rm -f .Xil -r
	-@rm -f *.log
	-@rm -f *.jou
	$(MAKE) -C $(TB_DIRS) clean
