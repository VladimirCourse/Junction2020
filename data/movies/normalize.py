import json
import csv

files = [
    'movies.json',
]

for f in files:
    with open(f) as json_file:
        data = json.load(json_file) 
        categories = {}
        with open('movies_genres.json') as cats_file:
            cats = json.load(cats_file)
            for c in cats:
                categories[c['id']] = c['name']

        with open('movies.csv', mode='a') as employee_file:
            writer = csv.writer(employee_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
            for line in data['results']:
                writer.writerow([
                    line['id'], line['title'], line['popularity'], line['overview'], 'https://image.tmdb.org/t/p/w500' + line['poster_path'] if line['poster_path'] else None,
                    ';'.join([str(i) for i in line['genre_ids']]),
                    ';'.join([categories[i] for i in line['genre_ids']]),
                ])