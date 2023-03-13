def checkm_filter(checkm, bins_all, bins_hq, bins_mq):
    """
    copy medium and high quality mags into a new folder for downstream use
    high quality - >90% completeness, <5% contamination, 23S, 16S, 5S rRNA genes, >18 tRNAs
    medium quality - >= 50% completeness, <10% contamination 

    inputs: 
        checkm 

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
    for each_bin in bin_filepath: # copying the bins to the new folder
        copy(each_bin, bins_hq)
        
        
    # medium quality
    os.makedirs(bins_mq)

    bins = [] # initialize empty lists to store bins of interest
    bin_filepath = []
    df = pd.read_table(checkm, sep = "\t")
    bins = df.query("Completeness <=90 & Contamination >5 & Completeness >=50 & Contamination <10")["Bin Id"] # bins with quality parameters matching
    bin_filepath = [os.path.join(bins_all, x + ".fa") for x in bins] # make a proper file path to access each bin
    for each_bin in bin_filepath: # copying the bins to the new folder
        copy(each_bin, bins_mq)
    
checkm_filter(snakemake.input[0], snakemake.input[1], snakemake.output[0], snakemake.output[1])