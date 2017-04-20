TB_DIRS = tb/or_gate

.PHONY: all
all:
	vivado -mode batch -source build_scripts/full_implementation.tcl

.PHONY: sim_or_gate
sim_or_gate:
	bash build_scripts/run_tb.sh or_gate testbench

.PHONY: clean
clean:
	-@rm -f or_gate.bit
	-@rm -f vivado -r
	-@rm -f .Xil -r
	-@rm -f *.log
	-@rm -f *.jou
	$(MAKE) -C $(TB_DIRS) clean
