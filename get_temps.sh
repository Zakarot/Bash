echo pve0
ssh pve0  sensors -A coretemp-isa-0000
echo stor0
ssh stor0 sensors -A k10temp-pci-00c3
echo stor1
ssh stor1 sensors -A coretemp-isa-0000
echo exec2
ssh exec2 sensors -A coretemp-isa-0000
echo exec3
ssh exec3 sensors -A coretemp-isa-0000
echo exec4
ssh exec4 sensors -A coretemp-isa-0000
