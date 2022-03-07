#!/usr/bin/env python3
import json
import requests as r
from sys import argv
# import asyncio

online = False
players = []
username = ""
hypixel_key = ""

if len(argv) == 1:
    online = False
elif len(argv) > 1:
    if argv[1] == "online":
        online = True
    else:
        players = argv[1:]

hypixel_status_url = "https://api.hypixel.net/status?key="+hypixel_key+"&uuid="
hypixel_friends_url = "https://api.hypixel.net/friends?key="+hypixel_key+"&uuid="
mojang_uuid_url = "https://api.mojang.com/users/profiles/minecraft/"
mojang_username_url = "https://api.mojang.com/user/profiles/" # then uuid, then "/names"

# async
def get_response(url):
    response = r.get(url)
    if response.status_code != 200:
        return None
    print(f"{url}: {response.text}")
    return json.loads(response.text)

def print_status(player, status):
    if status["session"]["online"]:
        print(f"{player} is online and is playing {status['session']['gameType']}")
    elif not online: # global var
        print(f"{player} is offline")

if players:

    for player in players:

        player_uuid_response = get_response(mojang_uuid_url + player)
        if not player_uuid_response:
            print(f"player {player} does not exist or an error ocurred")
            continue

        hypixel_status = get_response(hypixel_status_url + player_uuid_response["id"])
        print_status(player, hypixel_status)
    exit(0)

self_uuid_response = get_response(mojang_uuid_url + username)
if not self_uuid_response:
    print("your usename, {username}, does not exist or an error ocurred")
    exit(1)

friends_response = get_response(hypixel_friends_url + self_uuid_response["id"])

friends_uuid = []

for friend_data in friends_response["records"]:
    if(friend_data["uuidSender"] == self_uuid_response["id"]):
        friends_uuid.append(friend_data["uuidReceiver"])
    else:
        friends_uuid.append(friend_data["uuidSender"])

for friend_uuid in friends_uuid:
    friend_username_response = get_response(mojang_username_url + friend_uuid+"/names")
    friend_username = friend_username_response[-1]["name"] # -1 for last name -> most recent name
    friend_status_response = get_response(hypixel_status_url + friend_uuid)
    print_status(friend_username, friend_status_response)
