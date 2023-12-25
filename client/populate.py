#!/usr/bin/python3
## SCRIPT TO POPULATE THE DATABASE WITH RANDOMLY GENERATED USERS ##

import os
import requests
import json
from random import randrange

endpoint = "http://13.39.148.222:8080/"

names =["Liam",
"Noah",
"Oliver",
"Elijah",
"James",
"William",
"Benjamin",
"Lucas",
"Henry",
"Theodore",
"Jack",
"Levi",
"Alexander",
"Jackson",
"Mateo",
"Daniel",
"Michael",
"Mason",
"Sebastian",
"Ethan",
"Logan",
"Owen",
"Samuel",
"Jacob",
"Asher",
"Aiden",
"John",
"Joseph",
"Wyatt",
"David",
"Leo",
"Luke",
"Julian",
"Hudson",
"Grayson",
"Matthew",
"Ezra",
"Gabriel",
"Carter",
"Isaac",
"Jayden",
"Luca",
"Anthony",
"Dylan",
"Lincoln",
"Thomas",
"Maverick",
"Elias",
"Josiah",
"Charles",
"Caleb",
"Christopher",
"Ezekiel",
"Miles",
"Jaxon",
"Isaiah",
"Andrew",
"Joshua",
"Nathan",
"Nolan",
"Adrian",
"Cameron",
"Santiago",
"Eli",
"Aaron",
"Ryan",
"Angel",
"Cooper",
"Waylon",
"Easton",
"Kai",
"Christian",
"Landon",
"Colton",
"Roman",
"Axel",
"Brooks",
"Jonathan",
"Robert",
"Jameson",
"Ian",
"Everett",
"Greyson",
"Wesley",
"Jeremiah",
"Hunter",
"Leonardo",
"Jordan",
"Jose",
"Bennett",
"Silas",
"Nicholas",
"Parker",
"Beau",
"Weston",
"Austin",
"Connor",
"Carson",
"Dominic",
"Xavier",
"Jaxson",
"Jace",
"Emmett",
"Adam",
"Declan",
"Rowan",
"Micah",
"Kayden",
"Gael",
"River",
"Ryder",
"Kingston",
"Damian",
"Sawyer",
"Luka",
"Evan",
"Vincent",
"Legend",
"Myles",
"Harrison",
"August",
"Bryson",
"Amir",
"Giovanni",
"Chase",
"Diego",
"Milo",
"Jasper",
"Walker",
"Jason",
"Brayden",
"Cole",
"Nathaniel",
"George",
"Lorenzo",
"Zion",
"Luis",
"Archer",
"Enzo",
"Jonah",
"Thiago",
"Theo",
"Ayden",
"Zachary",
"Calvin",
"Braxton",
"Ashton",
"Rhett",
"Atlas",
"Jude",
"Bentley",
"Carlos",
"Ryker",
"Adriel",
"Arthur",
"Ace",
"Tyler",
"Jayce",
"Max",
"Elliot",
"Graham",
"Kaiden",
"Maxwell",
"Juan",
"Dean",
"Matteo",
"Malachi",
"Ivan",
"Elliott",
"Jesus",
"Emiliano",
"Messiah",
"Gavin",
"Maddox",
"Camden",
"Hayden",
"Leon",
"Antonio",
"Justin",
"Tucker",
"Brandon",
"Kevin",
"Judah",
"Finn",
"King",
"Brody",
"Xander",
"Nicolas",
"Charlie",
"Arlo",
"Emmanuel",
"Barrett",
"Felix",
"Alex",
"Miguel",
"Abel",
"Alan",
"Beckett",
"Amari",
"Karter",
"Timothy",
"Abraham",
"Jesse",
"Zayden",
"Blake",
"Alejandro",
"Dawson",
"Tristan",
"Victor",
"Avery",
"Joel",
"Grant",
"Eric",
"Patrick",
"Peter",
"Richard",
"Edward",
"Andres",
"Emilio",
"Colt",
"Knox",
"Beckham",
"Adonis",
"Kyrie",
"Matias",
"Oscar",
"Lukas",
"Marcus",
"Hayes",
"Caden",
"Remington",
"Griffin",
"Nash",
"Israel",
"Steven",
"Holden",
"Rafael",
"Zane",
"Jeremy",
"Kash",
"Preston",
"Kyler",
"Jax",
"Jett",
"Kaleb",
"Riley",
"Simon",
"Phoenix",
"Javier",
"Bryce",
"Louis",
"Mark",
"Cash",
"Lennox",
"Paxton",
"Malakai",
"Paul",
"Kenneth",
"Nico",
"Kaden",
"Lane",
"Kairo",
"Maximus",
"Omar",
"Finley",
"Atticus",
"Crew",
"Brantley",
"Colin",
"Dallas",
"Walter",
"Brady",
"Callum",
"Ronan",
"Hendrix",
"Jorge",
"Tobias",
"Clayton",
"Emerson",
"Damien",
"Zayn",
"Malcolm",
"Kayson",
"Bodhi",
"Bryan",
"Aidan",
"Cohen",
"Brian",
"Cayden",
"Andre",
"Niko"]

separators = ['', '.', '_']

for i in range(2):
    # REGISTER
    name1 = names[randrange(len(names))]
    separator = separators[randrange(len(separators))]
    name2 = names[randrange(len(names))]
    number = str(randrange(0, 99))
    email = name1.lower() + separator + name2.lower() + number + "@mail.com"

    payload = json.dumps({
    "email": email,
        "name":name1 + " " + name2,
    "password": "xxx"
    })

    headers = {
    'Content-Type': 'application/json'
    }


    response = requests.request("POST", endpoint + "register", headers=headers, data=payload) 


