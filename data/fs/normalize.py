import json
import csv

files = [
    'venue_monuments.json',
    'venue_art.json',
    'venue_movies.json',
    'venue_museum.json',
    'venue_music.json',
    'venue_nightlife.json',
    'venue_outdoors.json',
    'venue_sport.json',
    'venue_total.json',
]

# files = [
#     'rest_amer.json',
#     'rest_asia.json',
#     'rest_fastfood.json',
#     'rest_french.json',
#     'rest_german.json',
#     'rest_rus.json',
#     'rest_span.json',
#     'rest_total.json',
# ]


# for f in files:
#     with open(f) as json_file:
#         data = json.load(json_file) 
#         with open('events.csv', mode='a') as employee_file:
#             writer = csv.writer(employee_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
#             for line in data['response']['venues']:
#                 writer.writerow([
#                     line['id'], line['name'], line['location']['lat'], line['location']['lng'], 
#                     ';'.join(map(lambda x: x['name'], line['categories'])),
#                     ';'.join(map(lambda x: x['id'], line['categories']))
#                 ])

for f in files:
    with open(f) as json_file:
        data = json.load(json_file) 
        cats_ids = []
        cats_names = []
        for line in data['response']['venues']:
            cats_ids.append(line['categories'][0]['id'])
            cats_names.append(line['categories'][0]['name'])

        print(f)
        print(list(set(cats_ids)))
        print(list(set(cats_names)))