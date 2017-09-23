# Securities Order Execution Analysis 
## Introduction and Project Motivation
The financial markets have changed substantially over the years, and the days of the busy stock exchange floor have come to an end. Most trading now occurs electronically. Human buyers and sellers are matched up by complex algorithms that rapidly transact in an increasingly competitive environment where every nanosecond of latency has its impact on profit margins. According to a recent congressional research service [report](https://fas.org/sgp/crs/misc/R44443.pdf), high frequency trading (HFT) makes up roughly 55% of US equity trading volume. 

The effects of electronic trading have been debated extensively. Specific areas of consideration may include liquidity (the availability of securities to buy and sell), overall market efficiency, and transaction costs. Due to the competitive nature of the industry, the algorithms in use by electronic traders are proprietary and are effectively a "black box" to the average market participant. We can only observe the result of how markets are behaving.

## Problem Statement 

The goal is to assess which factors affect order execution quality accross different market centers, classes of security, and order types. The data is available from 2005 up until recent months for certain market centers, so an analysis can be conducted on how these factors have changed over an extended time period during which the market share and sophistication of electronic trading have increased.

## Available Data

In 2005, the US Securities and Exchange Commision (SEC) adopted [SEC Rule 605](http://www.finra.org/industry/sec-rule-605) which requires the Financial Industry Regulatory Authority (FINRA) to make available certain order execution information. Market centers that trade national market system securities must make available monthly reports in a standardized ASCII pipe-delimited [format](https://www.sec.gov/interps/legal/slbim12b.htm). A typical monthly report contains 25,000+ line items each representing a randomly selected order for a particular security. With dozens of market centers required to report and years of historical data, total available line items easily exceed 10 million. 

These reports include information about each market center's quality of executions on a stock-by-stock basis, including how market orders of various sizes are executed relative to the public quotes. These reports must also disclose information about effective spreads (i.e. the transaction costs paid by investors whose orders are routed to a particular market center). In addition, market centers must disclose the extent to which they provide executions at prices better than the public quotes to investors using limit orders. Finally, there are columns relating to how many shares were executed over varying time periods (i.e. within 0-9 seconds, 10-29 seconds, etc). 
