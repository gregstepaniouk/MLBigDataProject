using DataFrames

function parse_605()
    names = [:DPC,:MCC,:DATE,:TIKR,:ORTC,:ORSC,:TCOR,:TCSH,:CNSH,:MCSH,:AWSH,:f0t9,:f10t29,
        :f30t59,:f60t299,:ft30m,:ARSP,:AESP,:PISH,:PIAM,:PIAT,:AQSH,:AQAT,:OQSH,:OQAM,:OQAT]

    T1 = readtable("NYSE_ARCA/PARCAX201501.txt",header = false, separator = '|', names = names);  
    T2 = readtable("NYSE_ARCA/PARCAX201502.txt",header = false, separator = '|', names = names);
    T3 = readtable("NYSE_ARCA/PARCAX201503.txt",header = false, separator = '|', names = names);
    T4 = readtable("NYSE_ARCA/PARCAX201504.txt",header = false, separator = '|', names = names);
    T5 = readtable("NYSE_ARCA/PARCAX201505.txt",header = false, separator = '|', names = names);
    T6 = readtable("NYSE_ARCA/PARCAX201506.txt",header = false, separator = '|', names = names);
    T7 = readtable("NYSE_ARCA/PARCAX201507.txt",header = false, separator = '|', names = names);
    T8 = readtable("NYSE_ARCA/PARCAX201508.txt",header = false, separator = '|', names = names);
    T9 = readtable("NYSE_ARCA/PARCAX201509.txt",header = false, separator = '|', names = names);
    T10 = readtable("NYSE_ARCA/PARCAX201510.txt",header = false, separator = '|', names = names);
    T11 = readtable("NYSE_ARCA/PARCAX201511.txt",header = false, separator = '|', names = names);
    T12 = readtable("NYSE_ARCA/PARCAX201512.txt",header = false, separator = '|', names = names);

    TRADES = [T1;T2;T3;T4;T5;T6;T7;T8;T9;T10;T11;T12]

    #memory management
    T1 = 0; T2 = 0; T3 = 0; T4 = 0; T5 = 0; T6 = 0; T7 = 0;
    T8 = 0; T9 = 0; T10 = 0; T11 = 0; T12 = 0;

    TRADES = TRADES[TRADES[:ORTC] .<= 12 ,:];
    TRADES = TRADES[.!isna.(TRADES[:AESP]),:]; 

    delete!(TRADES,:DPC)
    delete!(TRADES,:MCC)

end