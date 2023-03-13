def checkm_filter(checkm, bins_all, bins_hq):
    """
    copy medium and high quality mags into a new folder for downstream use
    high quality - >90% completeness, <5% contamination, 23S, 16S, 5S rRNA genes, >18 tRNAs
    medium quality - >= 50% completeness, <10% contamination 

    inputs: 
        sample - sample wildcard for snakemake execution
        checkm_directory = snakemake input of checkm output files
        bin_directory = snakemake input of bin directory

    outputs:
        directories with bins of medium and high quality copied
    
    """
    from shutil import copy
    import pandas as pd
    import os
    
    # high quality
    os.makedirs(bins_hq)

    bins = [] # initialize empty lists to store bins of interest
    bin_filepath = []
    df = pd.read_table(checkm, sep = "\t")
    bins = df.query("Completeness >90 & Contamination <5")["Bin Id"] # bins with quality parameters matching
    bin_filepath = [os.path.join(bins_all, x + ".fa") for x in bins] # make a proper file path to access each bin
    for each_bin in bin_filepath: # copying the bins to the new folder??
        copy(each_bin, bins_hq)
    
checkm_filter("results/checkm/gao3/gao3_checkm_output.txt", "results/metabat_out/gao3/bins", "results/bins_filtered/gao3/hq")