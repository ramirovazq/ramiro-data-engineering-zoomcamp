#!/usr/bin/env python
# coding: utf-8

from time import time
from sqlalchemy import create_engine
import pandas as pd
import argparse
import pyarrow.parquet as pq
import os
import sys
 
def main(params):

    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url

    # download csv file
    file_name = url.rsplit('/', 1)[-1].strip()
    print(f'Downloading {file_name} ...')
    # Download file from url
    #os.system(f'curl {url.strip()} -o {file_name}')

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    if '.csv' in file_name:
        print("-------------------/////////--------------------")
        df = pd.read_csv(file_name, nrows=10, compression='gzip', dtype={'store_and_fwd_flag': str})
        df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
        df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)
        df_iter = pd.read_csv(file_name, iterator=True, chunksize=100000, dtype={'store_and_fwd_flag': str})
    elif '.parquet' in file_name:
        file = pq.ParquetFile(file_name)
        df = next(file.iter_batches(batch_size=10)).to_pandas()
        df_iter = file.iter_batches(batch_size=100000)
    else: 
        print('Error. Only .csv or .parquet files allowed.')
        sys.exit()


    # Create the table
    df.head(0).to_sql(name=table_name, con=engine, if_exists='replace')

    # Insert values
    t_start = time()
    count = 0
    for batch in df_iter:
        count+=1

        if '.parquet' in file_name:
            batch_df = batch.to_pandas()
        else:
            batch_df = batch

        print(f'inserting batch {count}...')

        b_start = time()
        batch_df.to_sql(name=table_name, con=engine, if_exists='append')
        b_end = time()

        print(f'inserted! time taken {b_end-b_start:10.3f} seconds.\n')
        
    t_end = time()   
    print(f'Completed! Total time taken was {t_end-t_start:10.3f} seconds for {count} batches.')   


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='Ingest csv data to postgres')

    parser.add_argument('--user', help='user name for postgres')
    parser.add_argument('--password', help='password name for postgres')
    parser.add_argument('--host', help='host for postgres')
    parser.add_argument('--port', help='port for postgres')
    parser.add_argument('--db', help='database name for postgres')
    parser.add_argument('--table_name', help='name of table name we will write the results to')
    parser.add_argument('--url', help='url of the csv file')

    args = parser.parse_args()

    main(args)

#URL = 'https://s3.amazonaws.com/ny-tlc/trip+data/yellow_tripdata_2021-01.csv'
#URL='https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2021-01.parquet'
#URL='https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-10.csv.gz'
#python ingest_data.py --user=root --password=root --host=localhost --port=5432 --db=ny_taxi --table_name=green_taxi_trips --url=${URL}
