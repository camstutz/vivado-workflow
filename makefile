.PHONY: all
all:
	vivado -mode batch -source build_scripts/full_implementation.tcl

.PHONY: clean
clean:
	-@rm or_gate.bit
	-@rm vivado -r
	-@rm .Xil -r
	-@rm *.log
	-@rm *.jou
