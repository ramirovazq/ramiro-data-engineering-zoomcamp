import csv
import json
import time
from kafka import KafkaProducer

def main(test):


    t0 = time.time()
    # Create a Kafka producer
    producer = KafkaProducer(
        bootstrap_servers='localhost:9092',
        value_serializer=lambda v: json.dumps(v).encode('utf-8')
    )

    csv_file = 'data/green_tripdata_2019-10.csv'  # change to your CSV file path if needed

    counter = 0
    with open(csv_file, 'r', newline='', encoding='utf-8') as file:
        reader = csv.DictReader(file)

        for row in reader:
            filtered_row = {
                'lpep_pickup_datetime': row['lpep_pickup_datetime'],
                'lpep_dropoff_datetime': row['lpep_dropoff_datetime'],
                'PULocationID': row['PULocationID'],
                'DOLocationID': row['DOLocationID'],
                'passenger_count': row['passenger_count'],
                'trip_distance': row['trip_distance'],
                'tip_amount': row['tip_amount']
            }
            # Each row will be a dictionary keyed by the CSV headers
            # Send data to Kafka topic "green-data"
            if test:
                producer.send('green-trips-test', value=filtered_row)
            else:
                producer.send('green-trips', value=filtered_row)

            if test:
                print(filtered_row)
                counter += 1
                if counter == 7:
                    break


        # Make sure any remaining messages are delivered
        producer.flush()
        producer.close()


    t1 = time.time()
    took = t1 - t0

    if test:
        print(f'TEST took {(t1 - t0):.2f} seconds')
    else:
        print(f'took {(t1 - t0):.2f} seconds')


if __name__ == "__main__":
    test = True
    main(test)