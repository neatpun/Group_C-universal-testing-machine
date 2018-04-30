import pandas as pd
import matplotlib.pyplot as plt

import os
import errno

import time

localtime = time.asctime( time.localtime(time.time()) ).replace(':','-')

def make_sure_path_exists(path):
    try:
        os.makedirs(path)
        os.makedirs(path+'/logs')
        os.makedirs(path+'/graphs')
    except OSError as exception:
        print("err")
        if exception.errno != errno.EEXIST:
            raise
    # if not os.path.exists(directory):
    #     os.makedirs(directory)

make_sure_path_exists(localtime)

di=pd.read_csv('motor.csv')
di["current_time"]=di["current_time"].round(2)

lv=pd.read_csv('load.csv',names=["ltime","lvalue"])
lv=lv.iloc[7:]
lv=lv.reset_index(drop=True)
lv.ltime = lv.ltime.astype(float)
lv.lvalue = lv.lvalue.astype(float)
lv["ltime"]=lv["ltime"].round(2)
lv=lv.groupby(['ltime']).mean()
lv=lv.reset_index()

comb=pd.merge(di,lv,left_on="current_time",right_on="ltime",how="inner")
new=comb.loc[:,["current_cycle","distance","lvalue"]]

new.to_csv(localtime+'/logs/hope.csv')
new.plot(x="distance",y="lvalue").get_figure().savefig(localtime+'/graphs/total.png')


for region, df_region in new.groupby('current_cycle'):
    # print(df_region)
    df_region.to_csv(localtime+'/logs/cycle{}.csv'.format(region))
    df_region.plot(x="distance",y="lvalue").get_figure().savefig(localtime+'/graphs/cycle{}.png'.format(region))


plt.show()


# now split on current cycle
