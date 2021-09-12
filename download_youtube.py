#!/usr/bin/env python3

import pytube
from sys import argv

if len(argv) < 2:
    print("usage: first argument is yt link")
    exit(1)

if "audio" not in argv and "video" not in argv:
    print("usage: specify audio and/or video as argument after link")
    exit(1)

LINK = argv[1]

VIDEO_DIR = "/home/<user>/media/movies"
AUDIO_DIR = "/home/sam/media/music"

print("downloading video...")
yt_vid = pytube.YouTube(LINK)


# returns list of filtered audio streams
if "audio" in argv:
    print("extracting audio stream...")
    audio_streams = yt_vid.streams.filter(only_audio=True)
    print("saving audio stream to " + AUDIO_DIR + "...")
    audio_streams[0].download(output_path=AUDIO_DIR)

if "video" in argv:
    video_file = yt_vid.streams.first()
    video_file.download(output_path=VIDEO_DIR)
