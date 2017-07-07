# helmstaedter_to_swc

The [Helmstaedter et al., Nature 2013 dataset](http://neuro.rzg.mpg.de/download/Helmstaedter_et_al_Nature_2013_skeletons_contacts_matrices.mat) contains thousands of skeletonizations of mouse retina in `.mat` format.

For some applications and analyses, the SWC format ([defined here](http://research.mssm.edu/cnic/swc.html)) is preferred.

The MATLAB script `helmstaedter_to_swc.m`, when placed in the same directory as the dataset file `Helmstaedter_et_al_Nature_2013_skeletons_contacts_matrices.mat`, writes all 4188 skeletons to SWC files in the same directory.

The files are named `cell[cellNumber]_[skeletonNumber].swc`, where `cellNumber` is the cellID provided by the dataset and `skeletonNumber` is a count of the number of skeletons written so far to the same cell.

At this time, offsets are not read from the `.mat` file.

[Helmstaedter M, Briggman KL, Turaga S, Jain V, Seung HS, Denk W (2013). Connectomic reconstruction of the inner plexiform layer in the mouse retina. Nature, doi: 10.1038/nature12346](http://neuro.rzg.mpg.de/)

