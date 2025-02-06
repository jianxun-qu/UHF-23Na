# UHF-23Na
MATLAB script for post-processing of 23Na imaging at UHF platform <br />

# System & Sequence
* System: Terra VE12U-SP01
* Coil: Rapid Dual-tuned 1H/23Na Coil. 1Tx/1Rx for 1H and 1Tx/32Rx for 23Na <https://www.rapidbiomed.de/product/multi-channel-dual-tuned-head-array-for-7-t/> <br />
* Sequence (C2P): 3D DA-RAD	<https://webclient.cn.api.teamplay.siemens-healthineers.cn/c2p> <br />
* Sequence (Product): uTE

## Package Required
* BM4D <https://webpages.tuni.fi/foi/GCF-BM3D/index.html> <br />
* SPM12 <https://www.fil.ion.ucl.ac.uk/spm/software/spm12/> <br />
* NIfTI_20140122 <https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image> <br />

## Protocol
Rapid 
1. Intensity correction <br />
Low resolution (LR) acquisition with short TR and different receiving coil setting <br />
LR with array coil (NAA) <br />
LR with volume coil (NAV) <br />
LR with array coil (NAA) <br />

2. High resolution 23Na imaging <br />
High resolution (HR) acquisition with long TR (120ms) and 90 degree flip angle. <br />

## Post-processing
1 
