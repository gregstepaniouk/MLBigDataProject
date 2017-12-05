using DataFrames
using JLD

function na_mean(key, df)
    if sum(.!isna.(df[key])) >= 3
        return mean(df[key][.!isna.(df[key])])
    else
        return NaN
    end
end


function parse_rv()
    RV = readtable("REALIZED_VOL.csv")
    
    delete!(RV,:secid);
    delete!(RV,:days);
    delete!(RV,:index_flag)
    
    RV[:date] = Date(Dates.lastdayofmonth.(DateTime(RV[:date],"m/d/y")));
    RV = RV[Dates.Year.(RV[:date]) .== Dates.Year(2015),:]

    println("Chose 2015")

    PCRSP = load("PCRSP.jld")["PCRSP"]

    println("Loaded Processed CRSP DataFrame")

    months = unique(RV[:date]);
    tickers = intersect(unique(PCRSP[:TICKER]),unique(RV[:ticker]));
    RV = RV[indexin(RV[:ticker],tickers).>0,:];

    println("Disposed of useless tickers")

    nt = size(tickers)[1];
    nm = size(months)[1];

    n = nm*nt; 

    MONTH = Vector{Date}(n);
    TICKER = Vector{String}(n);
    RVOL = Vector{Float64}(n);


    println("Brace yourself")

    for m = 1:nm
        for t = 1:nt
            i = t + nt*(m-1)
            TICKER[i] = tickers[t]
            MONTH[i] = months[m]
            temp = RV[RV[:ticker] .== tickers[t],:]
            temp = temp[temp[:date] .== months[m],:]
            RVOL[i] = na_mean(:volatility,temp)
        end
        println("Averaged 1 month")
    end

    return MONTH, TICKER, RVOL

end