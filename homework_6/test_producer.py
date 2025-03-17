import json
import time
from kafka import KafkaProducer

def json_serializer(data):
    return json.dumps(data).encode('utf-8')

server = 'localhost:9092'

producer = KafkaProducer(
    bootstrap_servers=[server],
    value_serializer=json_serializer
)

answer = producer.bootstrap_connected()
if answer:
    print("Is connected!")
    print(answer)
else:
    print("something wrong in connection")
