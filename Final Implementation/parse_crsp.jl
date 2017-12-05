
#This is used to parse the raw crsp dataset and extract monthly averages for 
#volume, shares outstanding, prices, and market maker count
#Everything is indexed by ticker and date

using DataFrames

function na_mean(key, df)
    if sum(.!isna.(df[key])) >= 3
        return mean(df[key][.!isna.(df[key])])
    else
        return NaN
    end
end

function parse_all()

    println("Starting up.")

    cd("/Users/greg/Desktop/4741/Project/DATA");
    CRSP = readtable("CRSP_RAW.csv");
    uticks = readtable("uniquetickers.csv")
    
    println("Imported Data")

    CRSP[:date] = Date(Dates.lastdayofmonth.(DateTime(CRSP[:date],"m/d/y")));
    CRSP = CRSP[Dates.Year.(CRSP[:date]) .== Dates.Year(2015),:]

    println("Chose 2015")

    CRSP = CRSP[.!isna.(CRSP[:TICKER]),:];

    months = unique(CRSP[:date]);
    tickers = intersect(unique(CRSP[:TICKER]),uticks[:TICKER]);
    CRSP = CRSP[indexin(CRSP[:TICKER],tickers).>0,:];

    println("Disposed of useless tickers")

    nt = size(tickers)[1];
    nm = size(months)[1];

    n = nm*nt; 

    take_avg = [:MMCNT,:PRC,:VOL,:SHROUT];

    println("Fixing NA Float Conversion Problems")
    
    for s in take_avg
        CRSP[s][isna.(CRSP[s])] = -7777 #feeling lucky?
        CRSP[s] = float(CRSP[s])
        CRSP[s][CRSP[s].==-7777] = NaN
    end

    CRSP_M = DataFrame();

    MMCNT = Vector{Float64}(n);
    PRC = Vector{Float64}(n);
    VOL = Vector{Float64}(n);
    SHROUT = Vector{Float64}(n);
    TICKER = Vector{String}(n);
    MONTH = Vector{Date}(n);


    
    println("Brace yourself")

    for m = 1:nm
        for t = 1:nt
            i = t + nt*(m-1)
            TICKER[i] = tickers[t]
            MONTH[i] = months[m]

            temp = CRSP[CRSP[:TICKER] .== tickers[t],:]
            temp = temp[temp[:date] .== months[m],:]

            MMCNT[i] = na_mean(:MMCNT,temp)
            PRC[i] = na_mean(:PRC,temp)
            VOL[i] = na_mean(:VOL,temp)
            SHROUT[i] = na_mean(:SHROUT,temp)  
        end
        println("Averaged 1 month")
    end

    return MONTH, TICKER, PRC, VOL, SHROUT, MMCNT
end


