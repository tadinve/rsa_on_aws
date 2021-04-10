
import pandas as pd
from random import choices
from datetime import  datetime
from faker import Faker

import scipy.stats as stats
def genValue(val_min,val_max,val_mean,val_std,valueType=float):

    if val_std == 0:
        return val_max

    dist = stats.truncnorm((val_min - val_mean) / val_std,
                       (val_max - val_mean) / val_std,
                       loc=val_mean, scale=val_std)

    try:
        x = valueType(dist.rvs())
    except:
        x = 0

    return x


from random import randint
def genrateSaleRecord(products_info, invoiceNo, stockCode, invoiceDate, fake):

    description = str(products_info["Description"]).replace(",", " ")

    qt_min,qt_max,qt_mean,qt_std = products_info[["qt_min","qt_max","qt_mean","qt_std"]]
    quantity = 	genValue(qt_min,qt_max,qt_mean,qt_std,int)

    up_min,up_max,up_mean,up_std = products_info[["up_min","up_max","up_mean","up_std"]]
    unitPrice = "{:.2f}".format(genValue(up_min,up_max,up_mean,up_std))

    invoiceDate = invoiceDate.strftime("%m/%d/%Y %H:%M:%S")

    customerID	= randint(10**6,10**7-1)
    country = fake.country().replace(","," ")
    return (invoiceNo,	stockCode,	description,	quantity,	invoiceDate, unitPrice,	customerID,	country)


def generateTransactions(startDate=datetime(2018,1,1), endDate=datetime(2021,3,27), n=10, OutFile=None):

    fake = Faker()

    df = pd.read_csv("cadabra_products.csv")
    product_names = list(df["StockCode"])
    product_probs = list(df["prob"])
    df.set_index('StockCode',inplace=True)

    prods = choices( population=product_names, weights=product_probs,k=n)

    invoiceDate = startDate
    delta = (endDate-startDate) / n
    #lines =[["InvoiceNo", "StockCode", "Description", "Quantity", "InvoiceDate", "UnitPrice", "CustomerID", "Country"]]
    lines = []
    for i in range(n):
        stockCode = prods[i]
        products_info = df.loc[stockCode]
        trans = genrateSaleRecord(products_info, i, stockCode, invoiceDate, fake)
        line = [str(i) for i in trans]
        lines.append(line)
        invoiceDate += delta
    records = []
    for line in lines:
        l = ",".join(line)
        records.append(l+"\n")
    if OutFile != None:
        with open(OutFile, "w") as file1:
            # Writing data to a file
            file1.writelines(records)
