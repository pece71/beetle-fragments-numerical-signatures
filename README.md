# beetle-fragments-numerical-signatures

MATLAB scripts for ROI extraction, augmentation, metadata logging, and numerical signature computation (skewness, kurtosis, entropy, std) for Curculionidae and Tenebrionidae beetle fragment dataset.

## Repository Structure

beetle-fragments-numerical-signatures/
├─ roi_extract_augment.m # Interactive ROI extraction & augmentation
├─ signature_extract.m # Numerical descriptor computation
├─ utils/
│ └─ metadata_checks.m # Metadata validation script
├─ examples/ # (to be added) sample input/output
├─ README.md
└─ LICENSE


## Requirements
- MATLAB R2024b (tested)
- Image Processing Toolbox

## Quick Start

1. **ROI Extraction & Augmentation**
   ```matlab
   roi_extract_augment
