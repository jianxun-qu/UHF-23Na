# UHF-23Na
MATLAB script for post-processing of 23Na imaging at UHF platform <br />

## System & Sequence
* System: Terra VE12U-SP01
* Coil: Rapid Dual-tuned 1H/23Na Coil. 1Tx/1Rx for 1H and 1Tx/32Rx for 23Na <br />
<https://www.rapidbiomed.de/product/multi-channel-dual-tuned-head-array-for-7-t/> <br />
* Sequence (C2P): 3D DA-RAD	<br />
<https://webclient.cn.api.teamplay.siemens-healthineers.cn/c2p> <br />
* Sequence (Product): uTE

## Package Required
* BM4D <https://webpages.tuni.fi/foi/GCF-BM3D/index.html> <br />
* SPM12 <https://www.fil.ion.ucl.ac.uk/spm/software/spm12/> <br />
* NIfTI_20140122 <https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image> <br />

## Protocol
The array coil provides higher signal-to-noise ratio (SNR). However, using an array coil can introduce signal intensity bias, where regions closer to the receiving channel exhibit higher signal intensity, while regions farther away show lower signal intensity. This bias must be corrected to ensure accurate imaging. <br />

The Rapid coil offers two receiving mode: one utilizing the array coil (NAA in Protocol Card) and the other using the volume voil (NAV). The volume coil does not suffer from signal intensity bias. To address intensity bias, the brain are images twice - once with array coil and once with the volume coil. The resulting images are then divided to generate an intensity correction map. To compensate for the volume coil's low SNR, multiple averages are acquired during the volume coil mode to enhance the signal. <br />

Additionally, to minimize the impact of motion during scans, the acquisition with array coil is also performed twice, immediatedly before and after the volume coil acquisition. These two array coil scans are then averaged to reduce motion's impact. <br />

1. Intensity correction <br />
Low resolution (LR) acquisition with short TR and different receiving coil setting <br />
LR with array coil (NAA: array coil) <br />
LR with volume coil (NAV: volume coil) <br />
LR with array coil (NAA: array coil again) <br />

2. High resolution 23Na imaging <br />
High resolution (HR) acquisition with long TR (120ms) and 90 degree flip angle. <br />

## Post-processing
1. Generate intensity correction map <br />
process_corr_map.m
2. Denoise, intensity correction, and quantification <br />
process.m
