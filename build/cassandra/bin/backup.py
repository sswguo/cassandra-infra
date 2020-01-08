import schedule
import time
import os
from datetime import datetime

def job():
    print("Taking snapshot ...")
    #TODO how to maintain the count of the snapshots, e.g.: keeping up to 5 snapshots always
    os.system("nodetool snapshot system -t 'snapshot-" + datetime.now().strftime('%Y%m%d%H%M%S') + "'")
    
#schedule.every(1).minutes.do(job)
schedule.every().hour.do(job)
#schedule.every().day.at("10:30").do(job)
#schedule.every(5).to(10).minutes.do(job)
#schedule.every().monday.do(job)
#schedule.every().wednesday.at("13:15").do(job)
#schedule.every().minute.at(":17").do(job)
 
while True:
    schedule.run_pending()
    time.sleep(1)
